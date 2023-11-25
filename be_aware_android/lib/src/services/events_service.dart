import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/exceptions/server_exception.dart';
import 'package:be_aware_android/src/services/api.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class EventsService {
  EventsService(this._api);
  final Api _api;

  Future<PageEventDto> getEvents(
    LatLng rectangleStart,
    LatLng rectangleEnd, {
    int page = 0,
    pageSize = 100,
  }) async {
    Response<PageEventDto> response = await _api.authClient.eventsGet(
      page: page,
      size: pageSize,
      rectangleStartLatitude: rectangleStart.latitude,
      rectangleStartLongitude: rectangleStart.longitude,
      rectangleEndLatitude: rectangleEnd.latitude,
      rectangleEndLongitude: rectangleEnd.longitude,
    );
    if (response.statusCode == 200) {
      return response.body!;
    } else {
      throw ServerException(status: response.statusCode);
    }
  }
}
