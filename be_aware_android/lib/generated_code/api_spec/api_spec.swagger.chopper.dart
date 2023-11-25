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
  Future<Response<TagDto>> _tagsTagIdPut({
    required int? tagId,
    required TagForm? body,
  }) {
    final Uri $url = Uri.parse('/tags/${tagId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TagDto, TagDto>($request);
  }

  @override
  Future<Response<dynamic>> _tagsTagIdDelete({required int? tagId}) {
    final Uri $url = Uri.parse('/tags/${tagId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<EventDto>> _eventsEventIdGet({required int? eventId}) {
    final Uri $url = Uri.parse('/events/${eventId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<EventDto, EventDto>($request);
  }

  @override
  Future<Response<EventDto>> _eventsEventIdPut({
    required int? eventId,
    required EventForm? body,
  }) {
    final Uri $url = Uri.parse('/events/${eventId}');
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
  Future<Response<dynamic>> _eventsEventIdDelete({required int? eventId}) {
    final Uri $url = Uri.parse('/events/${eventId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserDto>> _usersPost({required UserForm? body}) {
    final Uri $url = Uri.parse('/users');
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
  Future<Response<PageTagDto>> _tagsGet({
    int? page,
    int? size,
    List<String>? sort,
  }) {
    final Uri $url = Uri.parse('/tags');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'size': size,
      'sort': sort,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PageTagDto, PageTagDto>($request);
  }

  @override
  Future<Response<TagDto>> _tagsPost({required TagForm? body}) {
    final Uri $url = Uri.parse('/tags');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TagDto, TagDto>($request);
  }

  @override
  Future<Response<PageEventDto>> _eventsGet({
    int? page,
    int? size,
    List<String>? sort,
    required num? rectangleStartLatitude,
    required num? rectangleStartLongitude,
    required num? rectangleEndLatitude,
    required num? rectangleEndLongitude,
  }) {
    final Uri $url = Uri.parse('/events');
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
  Future<Response<EventDto>> _eventsPost({required EventForm? body}) {
    final Uri $url = Uri.parse('/events');
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
  Future<Response<dynamic>> _eventsEventIdImgPost({
    required int? eventId,
    required List<int> file,
  }) {
    final Uri $url = Uri.parse('/events/${eventId}/img');
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
  Future<Response<LoginResponse>> _authLoginPost({required UserForm? body}) {
    final Uri $url = Uri.parse('/auth/login');
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
    final Uri $url = Uri.parse('/auth/login');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<LoginResponse, LoginResponse>($request);
  }

  @override
  Future<Response<dynamic>> _eventsEventIdImgWebpGet({required int? eventId}) {
    final Uri $url = Uri.parse('/events/${eventId}/img.webp');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _authSayHelloGet() {
    final Uri $url = Uri.parse('/auth/say_hello');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }
}
