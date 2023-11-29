import 'dart:io';
import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/exceptions/server_exception.dart';
import 'package:be_aware_android/src/services/api.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

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

  Future<PageTagDto> getAllTags({
    int page = 0,
    pageSize = 100,
  }) async {
    Response<PageTagDto> response = await _api.authClient.tagsGet(
      page: page,
      size: pageSize,
    );
    if (response.statusCode == 200) {
      return response.body!;
    } else {
      throw ServerException(status: response.statusCode);
    }
  }

  Future<EventDto> postEvent(EventForm event) async {
    Response<EventDto> response = await _api.authClient.eventsPost(body: event);
    if (response.statusCode == 201) {
      return response.body!;
    } else {
      throw ServerException(status: response.statusCode);
    }
  }

  Future<void> postEventImage(int eventId, String filePath) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Api.baseUrl}events/$eventId/img"));

    var file = File(filePath);
    var stream = http.ByteStream(Stream.castFrom(file.openRead()));
    var length = await file.length();

    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(filePath),
      contentType: MediaType('image', 'webp'),
    );

    request.files.add(multipartFile);
    request.headers
        .addAll({'Authorization': 'Bearer ${_api.getAccessToken()}'});
    var responseStream = await request.send();
    http.Response response = await http.Response.fromStream(responseStream);
    if (response.statusCode == 204) {
      return;
    } else {
      throw ServerException(status: response.statusCode);
    }
  }
}
