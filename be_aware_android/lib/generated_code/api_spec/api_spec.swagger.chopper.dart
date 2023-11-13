// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_spec.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ApiSpec extends ApiSpec {
  _$ApiSpec([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiSpec;

  @override
  Future<Response<EventDto>> _eventEventIdGet({required int? eventId}) {
    final Uri $url = Uri.parse('/event/${eventId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<EventDto, EventDto>($request);
  }

  @override
  Future<Response<EventDto>> _eventEventIdPut({
    required int? eventId,
    required EventForm? body,
  }) {
    final Uri $url = Uri.parse('/event/${eventId}/');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<EventDto, EventDto>($request);
  }

  @override
  Future<Response<dynamic>> _eventEventIdDelete({required int? eventId}) {
    final Uri $url = Uri.parse('/event/${eventId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserDto>> _usersPost({required UserForm? body}) {
    final Uri $url = Uri.parse('/users/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<dynamic>> _eventEventIdImgPost({
    required int? eventId,
    required List<int> file,
  }) {
    final Uri $url = Uri.parse('/event/${eventId}/img/');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PageEventDto>> _eventGet({
    int? page,
    int? size,
    List<String>? sort,
    required num? rectangleStartLatitude,
    required num? rectangleStartLongitude,
    required num? rectangleEndLatitude,
    required num? rectangleEndLongitude,
  }) {
    final Uri $url = Uri.parse('/event/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'size': size,
      'sort': sort,
      'rectangleStartLatitude': rectangleStartLatitude,
      'rectangleStartLongitude': rectangleStartLongitude,
      'rectangleEndLatitude': rectangleEndLatitude,
      'rectangleEndLongitude': rectangleEndLongitude,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PageEventDto, PageEventDto>($request);
  }

  @override
  Future<Response<EventDto>> _eventPost({required EventForm? body}) {
    final Uri $url = Uri.parse('/event/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<EventDto, EventDto>($request);
  }

  @override
  Future<Response<LoginResponse>> _authLoginPost({required UserForm? body}) {
    final Uri $url = Uri.parse('/auth/login/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginResponse, LoginResponse>($request);
  }

  @override
  Future<Response<LoginResponse>> _authLoginPatch() {
    final Uri $url = Uri.parse('/auth/login/');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<LoginResponse, LoginResponse>($request);
  }

  @override
  Future<Response<dynamic>> _eventEventIdImgWebpGet({required int? eventId}) {
    final Uri $url = Uri.parse('/event/${eventId}/img.webp');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _authSayHelloGet() {
    final Uri $url = Uri.parse('/auth/say_hello/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }
}
