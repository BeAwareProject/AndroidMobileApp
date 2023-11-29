import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class StreamMarker extends Marker {
  final StreamDto stream;
  StreamMarker({required this.stream})
      : super(
          width: 40,
          height: 20,
          point: LatLng(
            stream.createdLocation.latitude,
            stream.createdLocation.longitude,
          ),
          child: _LivePointer(stream: stream),
        );
}

class _LivePointer extends StatelessWidget {
  const _LivePointer({required this.stream});
  final StreamDto stream;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/stream", extra: stream);
      },
      child: Container(
        width: 10,
        decoration: BoxDecoration(
          color: AppColors.liveMarker,
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
            "LIVE",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
