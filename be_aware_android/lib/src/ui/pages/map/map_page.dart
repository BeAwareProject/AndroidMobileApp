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

  final Key key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeAware'),
      ),
      body: FutureBuilder<LatLng?>(
        future: _getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Stack(
              children: [
                FlutterMap(
                  mapController: MapController(),
                  options: MapOptions(
                    initialCenter: snapshot.data ?? const LatLng(0, 0),
                    initialZoom: snapshot.data != null ? 15 : 2,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      //userAgentPackageName: 'com.example.app',
                    ),
                    snapshot.data != null
                        ? MarkerLayer(
                            markers: [
                              Marker(
                                width: 17.0,
                                height: 17.0,
                                point: snapshot.data as LatLng,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.lightBlue,
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  left: 80,
                  right: 80,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Report danger'),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 300,
                          height: 43,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            // Adjust the radius as needed
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 8),
                                  Icon(Icons.search),
                                  SizedBox(width: 4),
                                  Text('Search'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.layers_outlined),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
