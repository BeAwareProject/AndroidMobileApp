import 'dart:async';
import 'dart:io';
import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/services/events_service.dart';
import 'package:be_aware_android/src/services/localization_service.dart';
import 'package:be_aware_android/src/services/streams_service.dart';
import 'package:be_aware_android/src/ui/common/exceptions/location_disabled_exception_widget.dart';
import 'package:be_aware_android/src/ui/common/exceptions/offline_exception_widget.dart';
import 'package:be_aware_android/src/ui/common/navigations/settings_navigation_drawer.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/current_location_marker.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/event_marker.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/event_marker_small.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/stream_marker.dart';
import 'package:be_aware_android/src/ui/pages/map/pointers/stream_marker_small.dart';
import 'package:be_aware_android/src/ui/pages/map/widgets/layers_bottom_sheet.dart';
import 'package:be_aware_android/src/ui/pages/map/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Key _mapKey = GlobalKey();
  final MapController _mapController = MapController();
  final EventsService _eventsService = getIt();
  final StreamsService _streamsService = getIt();
  final LocalizationService _localizationService = getIt();

  late Timer _locationTimer;

  LatLng? _currentLocation;
  LatLng? _initLocation;
  LatLng? _lastLocation;

  bool _showSmallMarkers = false;
  bool _locationDisabledError = false;
  bool _offlineError = false;

  List<EventDto> _events = [];
  List<StreamDto> _streams = [];
  StreamSubscription<void>? _lastMapItemsUpdateAction;

  @override
  void initState() {
    super.initState();
    initMap();
  }

  Future<void> initMap() async {
    try {
      await _updateLocation();
    } on LocationServiceDisabledException {}

    _locationTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        _updateLocation();
      },
    );
    _updatePointers();
  }

  @override
  void dispose() {
    super.dispose();
    _locationTimer.cancel();
    _mapController.dispose();
  }

  Future<void> _updateLocation() async {
    try {
      var location = await _localizationService.getCurrentLocation();
      if (location != null) {
        setState(() {
          _currentLocation = location;
          _lastLocation = location;
          _initLocation ??= location;
        });
      } else {
        setState(() {
          _currentLocation = null;
        });
      }
    } on LocationServiceDisabledException {
      if (_initLocation == null) {
        setState(() {
          _locationDisabledError = true;
        });
      } else if (_lastLocation != null) {
        setState(() {
          _currentLocation = null;
        });
      }
    }
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
    if (_lastMapItemsUpdateAction != null) {
      _lastMapItemsUpdateAction!.cancel();
    }
    _lastMapItemsUpdateAction = Future.delayed(
      const Duration(milliseconds: 500),
    ).asStream().listen((_) {
      _getAndSetNewEventsForMapBounds();
      _getAndSetNewStreamsForMapBounds();
    });
  }

  Future<void> _getAndSetNewEventsForMapBounds() async {
    try {
      LatLngBounds visibleMapBounds = _mapController.camera.visibleBounds;
      PageEventDto pageEvent = await _eventsService.getEvents(
        visibleMapBounds.northWest,
        visibleMapBounds.southEast,
      );
      setState(() {
        _events = pageEvent.content != null ? pageEvent.content! : [];
      });
    } on SocketException {
      setState(() {
        _offlineError = true;
      });
    }
  }

  Future<void> _getAndSetNewStreamsForMapBounds() async {
    LatLngBounds visibleMapBounds = _mapController.camera.visibleBounds;
    PageStreamDto pageStream = await _streamsService.getStreams(
      visibleMapBounds.northWest,
      visibleMapBounds.southEast,
    );
    setState(() {
      _streams = pageStream.content != null ? pageStream.content! : [];
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

  Future<void> _retry() async {
    setState(() {
      _locationDisabledError = false;
      _offlineError = false;
    });
    await _updateLocation();
    _updatePointers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeAware'),
      ),
      drawer: const SettingsNavigationDrawer(),
      body: _offlineError
          ? OfflineExceptionWidget(onRetry: _retry)
          : _locationDisabledError
              ? LocationDisabledExceptionWidget(onRetry: _retry)
              : _initLocation == null
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
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            ),
                            _streams.isNotEmpty
                                ? MarkerLayer(
                                    markers: _streams
                                        .map(
                                          (stream) => _showSmallMarkers
                                              ? StreamMarkerSmall(
                                                  stream: stream)
                                              : StreamMarker(stream: stream),
                                        )
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
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 10),
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
