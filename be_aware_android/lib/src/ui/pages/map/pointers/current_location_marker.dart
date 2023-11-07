import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CurrentLocationMarker extends Marker {
  final LatLng position;
  final bool outDated;
  CurrentLocationMarker({required this.position, this.outDated = false})
      : super(
          width: 17,
          height: 17,
          point: position,
          child: _CurrentLocationPointer(outDated: outDated),
        );
}

class _CurrentLocationPointer extends StatelessWidget {
  const _CurrentLocationPointer({required this.outDated});
  final bool outDated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: outDated ? Colors.grey : Colors.lightBlue,
        border: const Border.fromBorderSide(
          BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
