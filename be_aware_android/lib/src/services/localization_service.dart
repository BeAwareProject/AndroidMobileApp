import 'package:be_aware_android/src/exceptions/location_service_no_permission_exception.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;

@injectable
class LocalizationService {
  Future<LatLng> getCurrentLocation() async {
    try {
      if (!(await Permission.location.isGranted)) {
        PermissionStatus status = await Permission.location.request();
        if (!status.isGranted) {
          throw LocationServiceNoPermissionException();
        }
      }
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw const LocationServiceDisabledException();
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      return LatLng(position.latitude, position.longitude);
    } on LocationServiceDisabledException {
      rethrow;
    } on LocationServiceNoPermissionException {
      rethrow;
    } catch (e) {
      developer.log(e.toString(), name: "LocalizationService");
      rethrow;
    }
  }
}
