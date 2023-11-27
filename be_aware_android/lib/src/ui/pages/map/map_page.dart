import 'dart:async';
import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/models/live.dart';
import 'package:be_aware_android/src/services/events_service.dart';
import 'package:be_aware_android/src/ui/common/navigations/settings_navigation_drawer.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/current_location_marker.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/event_marker.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/event_marker_small.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/live_marker.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/live_marker_small.dart';
import 'package:be_aware_android/src/ui/pages/map/widgets/layers_bottom_sheet.dart';
import 'package:be_aware_android/src/ui/pages/map/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
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
  final EventsService _eventsService = getIt();

  late Timer _locationTimer;
  LatLng? _currentLocation;
  LatLng? _initLocation;
  LatLng? _lastLocation;

  bool _showSmallMarkers = false;
  List<EventDto> _events = [];
  StreamSubscription<void>? _lastEventsUpdateAction;

  final List<Live> _lives = [
    Live(position: const LatLng(51.073716, 16.990467)),
    Live(position: const LatLng(51.073897, 16.997748)),
    Live(position: const LatLng(51.110026, 17.055876)),
    Live(position: const LatLng(51.109264, 17.063568)),
    Live(position: const LatLng(51.110139, 17.059891)),
    Live(position: const LatLng(51.113179, 17.026402)),
  ];

  /*final List<Event> _events = [
    Event(position: const LatLng(51.070985, 16.991848)),
    Event(position: const LatLng(51.108462, 17.056878)),
    Event(position: const LatLng(51.111634, 17.056981)),
    Event(position: const LatLng(51.112122, 17.040233)),
  ];*/

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

  void _handleMapPositionChange(MapPosition position, bool hasGesture) {
    if (position.zoom != null) {
      setState(() {
        if (position.zoom! > 15) {
          _showSmallMarkers = false;
        } else {
          _showSmallMarkers = true;
        }
      });
    }
    _updatePointers();
  }

  void _updatePointers() {
    if (_lastEventsUpdateAction != null) {
      _lastEventsUpdateAction!.cancel();
    }
    _lastEventsUpdateAction = Future.delayed(
      const Duration(milliseconds: 500),
    ).asStream().listen((_) {
      _getAndSetNewEventsForMapBounds();
    });
  }

  Future<void> _getAndSetNewEventsForMapBounds() async {
    LatLngBounds visibleMapBounds = _mapController.camera.visibleBounds;
    PageEventDto pageEvent = await _eventsService.getEvents(
      visibleMapBounds.northWest,
      visibleMapBounds.southEast,
    );
    setState(() {
      _events = pageEvent.content != null ? pageEvent.content! : [];
    });
  }

  void _showLayersBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const LayersBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeAware'),
      ),
      drawer: const SettingsNavigationDrawer(),
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
                    onPositionChanged: _handleMapPositionChange,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                    ),
                    _lives.isNotEmpty
                        ? MarkerLayer(
                            markers: _lives
                                .map((live) => _showSmallMarkers
                                    ? LiveMarkerSmall(position: live.position)
                                    : LiveMarker(position: live.position))
                                .toList(),
                          )
                        : const SizedBox(),
                    _events.isNotEmpty
                        ? MarkerLayer(
                            markers: _events
                                .map(
                                  (event) => _showSmallMarkers
                                      ? EventMarkerSmall(event: event)
                                      : EventMarker(event: event),
                                )
                                .toList(),
                          )
                        : const SizedBox(),
                    _currentLocation != null
                        ? MarkerLayer(
                            markers: [
                              CurrentLocationMarker(
                                position: _currentLocation!,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    _currentLocation == null && _lastLocation != null
                        ? MarkerLayer(
                            markers: [
                              CurrentLocationMarker(
                                position: _lastLocation!,
                                outDated: true,
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SearchContainer(
                    onTapLayers: _showLayersBottomSheet,
                  ),
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
                          onPressed: () {
                            context.push("/event/post");
                          },
                          child: const Icon(
                            Icons.report_outlined,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
