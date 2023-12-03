import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/exceptions/server_exception.dart';
import 'package:be_aware_android/src/services/api.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'dart:developer' as developer;

@injectable
class StreamsService {
  StreamsService(this._api);
  final Api _api;

  Future<PageStreamDto> getStreams(
    LatLng rectangleStart,
    LatLng rectangleEnd, {
    int page = 0,
    pageSize = 100,
  }) async {
    Response<PageStreamDto> response = await _api.authClient.streamsGet(
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

  Future<StreamPublishDto> postStream(StreamForm streamForm) async {
    Response<StreamPublishDto> response =
        await _api.authClient.streamsPost(body: streamForm);
    if (response.statusCode == 201) {
      developer.log(response.body!.toJson().toString(), name: 'StreamsService');
      return response.body!;
    } else {
      throw ServerException(status: response.statusCode);
    }
  }
}
