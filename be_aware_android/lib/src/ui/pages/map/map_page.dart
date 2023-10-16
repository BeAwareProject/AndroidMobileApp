import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with OSMMixinObserver {
  late final MapController controller = MapController.withUserPosition(
      trackUserLocation: UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ));

  @override
  void initState() {
    super.initState();
    controller.addObserver(this);
  }

  final Key key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeAware'),
      ),
      body: Center(
        child: OSMFlutter(
          key: key,
          controller: controller,
          osmOption: const OSMOption(
            userTrackingOption: UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: ZoomOption(
              initZoom: 13,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> mapIsReady(bool isReady) {
    return Future<void>.value();
  }
}
