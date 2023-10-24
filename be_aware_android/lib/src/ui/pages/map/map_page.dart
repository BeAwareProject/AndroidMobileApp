import 'dart:async';
import 'package:be_aware_android/src/models/live.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/current_location_pointer.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/live_pointer.dart';
import 'package:be_aware_android/src/ui/pages/map/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Key _mapKey = GlobalKey();
  final MapController _mapController = MapController();
  late Timer _locationTimer;
  LatLng? _currentLocation;
  LatLng? _initLocation;
  LatLng? _lastLocation;
  final List<Live> _lives = [
    Live(position: const LatLng(51.073716, 16.990467)),
    Live(position: const LatLng(51.073897, 16.997748)),
    Live(position: const LatLng(51.110026, 17.055876)),
    Live(position: const LatLng(51.109264, 17.063568)),
    Live(position: const LatLng(51.110139, 17.059891)),
  ];

  @override
  void initState() {
    super.initState();
    _locationTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        _updateLocation();
      },
    );
    _getCurrentLocation().then((loc) {
      setState(() {
        _currentLocation = loc;
        _initLocation = loc;
        _lastLocation = loc;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _locationTimer.cancel();
    _mapController.dispose();
  }

  Future<LatLng?> _getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
        return LatLng(position.latitude, position.longitude);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> _updateLocation() async {
    var location = await _getCurrentLocation();
    setState(() {
      _currentLocation = location;
      if (location != null) _lastLocation = location;
    });
  }

  void _goToCurrentLocation() {
    if (_currentLocation != null) {
      _mapController.moveAndRotate(_currentLocation!, 16, 0);
    } else if (_lastLocation != null) {
      _mapController.moveAndRotate(_lastLocation!, 16, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeAware'),
      ),
      body: _initLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  key: _mapKey,
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _initLocation!,
                    initialZoom: 14,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                    ),
                    _currentLocation != null
                        ? MarkerLayer(
                            markers: [
                              Marker(
                                width: 17.0,
                                height: 17.0,
                                point: _currentLocation!,
                                child: const CurrentLocationPointer(),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    _currentLocation == null && _lastLocation != null
                        ? MarkerLayer(
                            markers: [
                              Marker(
                                width: 17.0,
                                height: 17.0,
                                point: _lastLocation!,
                                child: const CurrentLocationPointer(
                                    outDated: true),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    _lives.isNotEmpty
                        ? MarkerLayer(
                            markers: _lives.map((live) {
                              return Marker(
                                width: 40,
                                height: 20,
                                point: live.position,
                                child: const LivePointer(),
                              );
                            }).toList(),
                          )
                        : const SizedBox(),
                    /*_lives.map((live) {
                      return Marker(
                        width: 17.0,
                        height: 17.0,
                        point: live.position,
                        child, // Create a custom marker widget
                      );
                    }).toList(),*/
                  ],
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: SearchContainer(),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: _goToCurrentLocation,
                          child: const Icon(Icons.my_location_outlined),
                        ),
                        const SizedBox(height: 10),
                        FloatingActionButton(
                          backgroundColor:
                              const Color.fromARGB(255, 195, 65, 25),
                          foregroundColor: Colors.white,
                          onPressed: () {},
                          child: const Icon(
                            Icons.report_outlined,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 16, right: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Report danger'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        FloatingActionButton(
                          onPressed: () {},
                          child: const Icon(Icons.my_location_outlined),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
    );
  }
}
