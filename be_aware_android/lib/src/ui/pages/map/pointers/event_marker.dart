import 'package:be_aware_android/src/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventMarker extends Marker {
  final LatLng position;
  const EventMarker({required this.position})
      : super(
          width: 55,
          height: 20,
          point: position,
          child: const _LivePointer(),
        );
}

class _LivePointer extends StatelessWidget {
  const _LivePointer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(
        color: AppColors.eventMarker,
        borderRadius: BorderRadius.circular(13),
        border: const Border.fromBorderSide(
          BorderSide(
            color: Colors.white,
            width: 0.9,
          ),
        ),
      ),
      child: Center(
        child: Text(
          "EVENT",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
