import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventMarkerSmall extends Marker {
  final EventDto event;
  EventMarkerSmall({required this.event})
      : super(
          width: 10,
          height: 10,
          point: LatLng(
            event.location.latitude,
            event.location.longitude,
          ),
          child: const _LivePointer(),
        );
}

class _LivePointer extends StatelessWidget {
  const _LivePointer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.eventMarker,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
