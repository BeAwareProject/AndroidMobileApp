// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;

part 'api_spec.swagger.chopper.dart';
part 'api_spec.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class ApiSpec extends ChopperService {
  static ApiSpec create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    Converter? converter,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$ApiSpec(client);
    }

    final newClient = ChopperClient(
        services: [_$ApiSpec()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$ApiSpec(newClient);
  }

  ///[AUTH REQUIRED] [ADMIN ONLY]
  ///@param tagId
  Future<chopper.Response<TagDto>> tagsTagIdPut({
    required int? tagId,
    required TagForm? body,
  }) {
    generatedMapping.putIfAbsent(TagDto, () => TagDto.fromJsonFactory);

    return _tagsTagIdPut(tagId: tagId, body: body);
  }

  ///[AUTH REQUIRED] [ADMIN ONLY]
  ///@param tagId
  @Put(
    path: '/tags/{tagId}',
    optionalBody: true,
  )
  Future<chopper.Response<TagDto>> _tagsTagIdPut({
    @Path('tagId') required int? tagId,
    @Body() required TagForm? body,
  });

  ///[AUTH REQUIRED] [ADMIN ONLY]
  ///@param tagId
  Future<chopper.Response> tagsTagIdDelete({required int? tagId}) {
    return _tagsTagIdDelete(tagId: tagId);
  }

  ///[AUTH REQUIRED] [ADMIN ONLY]
  ///@param tagId
  @Delete(path: '/tags/{tagId}')
  Future<chopper.Response> _tagsTagIdDelete(
      {@Path('tagId') required int? tagId});

  ///
  ///@param eventId
  Future<chopper.Response<EventDto>> eventsEventIdGet({required int? eventId}) {
    generatedMapping.putIfAbsent(EventDto, () => EventDto.fromJsonFactory);

    return _eventsEventIdGet(eventId: eventId);
  }

  ///
  ///@param eventId
  @Get(path: '/events/{eventId}')
  Future<chopper.Response<EventDto>> _eventsEventIdGet(
      {@Path('eventId') required int? eventId});

  ///[AUTH REQUIRED] [ADMIN ONLY]
  ///@param eventId
  Future<chopper.Response<EventDto>> eventsEventIdPut({
    required int? eventId,
    required EventForm? body,
  }) {
    generatedMapping.putIfAbsent(EventDto, () => EventDto.fromJsonFactory);

    return _eventsEventIdPut(eventId: eventId, body: body);
  }

  ///[AUTH REQUIRED] [ADMIN ONLY]
  ///@param eventId
  @Put(
    path: '/events/{eventId}',
    optionalBody: true,
  )
  Future<chopper.Response<EventDto>> _eventsEventIdPut({
    @Path('eventId') required int? eventId,
    @Body() required EventForm? body,
  });

  ///[AUTH REQUIRED] [ADMIN ONLY]
  ///@param eventId
  Future<chopper.Response> eventsEventIdDelete({required int? eventId}) {
    return _eventsEventIdDelete(eventId: eventId);
  }

  ///[AUTH REQUIRED] [ADMIN ONLY]
  ///@param eventId
  @Delete(path: '/events/{eventId}')
  Future<chopper.Response> _eventsEventIdDelete(
      {@Path('eventId') required int? eventId});

  ///
  Future<chopper.Response<UserDto>> usersPost({required UserForm? body}) {
    generatedMapping.putIfAbsent(UserDto, () => UserDto.fromJsonFactory);

    return _usersPost(body: body);
  }

  ///
  @Post(
    path: '/users',
    optionalBody: true,
  )
  Future<chopper.Response<UserDto>> _usersPost(
      {@Body() required UserForm? body});

  ///
  ///@param page Zero-based page index (0..N)
  ///@param size The size of the page to be returned
  ///@param sort Sorting criteria in the format: property,(asc|desc). Default sort order is ascending. Multiple sort criteria are supported.
  Future<chopper.Response<PageTagDto>> tagsGet({
    int? page,
    int? size,
    List<String>? sort,
  }) {
    generatedMapping.putIfAbsent(PageTagDto, () => PageTagDto.fromJsonFactory);

    return _tagsGet(page: page, size: size, sort: sort);
  }

  ///
  ///@param page Zero-based page index (0..N)
  ///@param size The size of the page to be returned
  ///@param sort Sorting criteria in the format: property,(asc|desc). Default sort order is ascending. Multiple sort criteria are supported.
  @Get(path: '/tags')
  Future<chopper.Response<PageTagDto>> _tagsGet({
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sort') List<String>? sort,
  });

  ///[AUTH REQUIRED] [ADMIN ONLY]
  Future<chopper.Response<TagDto>> tagsPost({required TagForm? body}) {
    generatedMapping.putIfAbsent(TagDto, () => TagDto.fromJsonFactory);

    return _tagsPost(body: body);
  }

  ///[AUTH REQUIRED] [ADMIN ONLY]
  @Post(
    path: '/tags',
    optionalBody: true,
  )
  Future<chopper.Response<TagDto>> _tagsPost({@Body() required TagForm? body});

  ///
  ///@param page Zero-based page index (0..N)
  ///@param size The size of the page to be returned
  ///@param sort Sorting criteria in the format: property,(asc|desc). Default sort order is ascending. Multiple sort criteria are supported.
  ///@param rectangleStartLatitude
  ///@param rectangleStartLongitude
  ///@param rectangleEndLatitude
  ///@param rectangleEndLongitude
  Future<chopper.Response<PageEventDto>> eventsGet({
    int? page,
    int? size,
    List<String>? sort,
    required num? rectangleStartLatitude,
    required num? rectangleStartLongitude,
    required num? rectangleEndLatitude,
    required num? rectangleEndLongitude,
  }) {
    generatedMapping.putIfAbsent(
        PageEventDto, () => PageEventDto.fromJsonFactory);

    return _eventsGet(
        page: page,
        size: size,
        sort: sort,
        rectangleStartLatitude: rectangleStartLatitude,
        rectangleStartLongitude: rectangleStartLongitude,
        rectangleEndLatitude: rectangleEndLatitude,
        rectangleEndLongitude: rectangleEndLongitude);
  }

  ///
  ///@param page Zero-based page index (0..N)
  ///@param size The size of the page to be returned
  ///@param sort Sorting criteria in the format: property,(asc|desc). Default sort order is ascending. Multiple sort criteria are supported.
  ///@param rectangleStartLatitude
  ///@param rectangleStartLongitude
  ///@param rectangleEndLatitude
  ///@param rectangleEndLongitude
  @Get(path: '/events')
  Future<chopper.Response<PageEventDto>> _eventsGet({
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sort') List<String>? sort,
    @Query('rectangleStartLatitude') required num? rectangleStartLatitude,
    @Query('rectangleStartLongitude') required num? rectangleStartLongitude,
    @Query('rectangleEndLatitude') required num? rectangleEndLatitude,
    @Query('rectangleEndLongitude') required num? rectangleEndLongitude,
  });

  ///[AUTH REQUIRED]
  Future<chopper.Response<EventDto>> eventsPost({required EventForm? body}) {
    generatedMapping.putIfAbsent(EventDto, () => EventDto.fromJsonFactory);

    return _eventsPost(body: body);
  }

  ///[AUTH REQUIRED]
  @Post(
    path: '/events',
    optionalBody: true,
  )
  Future<chopper.Response<EventDto>> _eventsPost(
      {@Body() required EventForm? body});

  ///[AUTH REQUIRED] [OWNERSHIP GUARD]
  ///@param eventId
  Future<chopper.Response> eventsEventIdImgPost({
    required int? eventId,
    required List<int> file,
  }) {
    return _eventsEventIdImgPost(eventId: eventId, file: file);
  }

  ///[AUTH REQUIRED] [OWNERSHIP GUARD]
  ///@param eventId
  @Post(
    path: '/events/{eventId}/img',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response> _eventsEventIdImgPost({
    @Path('eventId') required int? eventId,
    @PartFile() required List<int> file,
  });

  ///[LOGIN/PASSWORD REQUIRED] creates and returns refresh and access tokens
  Future<chopper.Response<LoginResponse>> authLoginPost(
      {required UserForm? body}) {
    generatedMapping.putIfAbsent(
        LoginResponse, () => LoginResponse.fromJsonFactory);

    return _authLoginPost(body: body);
  }

  ///[LOGIN/PASSWORD REQUIRED] creates and returns refresh and access tokens
  @Post(
    path: '/auth/login',
    optionalBody: true,
  )
  Future<chopper.Response<LoginResponse>> _authLoginPost(
      {@Body() required UserForm? body});

  ///[REFRESH TOKEN REQUIRED] refreshes and returns refresh and access tokens
  Future<chopper.Response<LoginResponse>> authLoginPatch() {
    generatedMapping.putIfAbsent(
        LoginResponse, () => LoginResponse.fromJsonFactory);

    return _authLoginPatch();
  }

  ///[REFRESH TOKEN REQUIRED] refreshes and returns refresh and access tokens
  @Patch(
    path: '/auth/login',
    optionalBody: true,
  )
  Future<chopper.Response<LoginResponse>> _authLoginPatch();

  ///
  ///@param eventId
  Future<chopper.Response> eventsEventIdImgWebpGet({required int? eventId}) {
    return _eventsEventIdImgWebpGet(eventId: eventId);
  }

  ///
  ///@param eventId
  @Get(path: '/events/{eventId}/img.webp')
  Future<chopper.Response> _eventsEventIdImgWebpGet(
      {@Path('eventId') required int? eventId});

  ///
  Future<chopper.Response<String>> authSayHelloGet() {
    return _authSayHelloGet();
  }

  ///
  @Get(path: '/auth/say_hello')
  Future<chopper.Response<String>> _authSayHelloGet();
}

@JsonSerializable(explicitToJson: true)
class TagForm {
  const TagForm({
    required this.name,
    required this.langtag,
  });

  factory TagForm.fromJson(Map<String, dynamic> json) =>
      _$TagFormFromJson(json);

  static const toJsonFactory = _$TagFormToJson;
  Map<String, dynamic> toJson() => _$TagFormToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'langtag')
  final String langtag;
  static const fromJsonFactory = _$TagFormFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TagForm &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.langtag, langtag) ||
                const DeepCollectionEquality().equals(other.langtag, langtag)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(langtag) ^
      runtimeType.hashCode;
}

extension $TagFormExtension on TagForm {
  TagForm copyWith({String? name, String? langtag}) {
    return TagForm(name: name ?? this.name, langtag: langtag ?? this.langtag);
  }

  TagForm copyWithWrapped({Wrapped<String>? name, Wrapped<String>? langtag}) {
    return TagForm(
        name: (name != null ? name.value : this.name),
        langtag: (langtag != null ? langtag.value : this.langtag));
  }
}

@JsonSerializable(explicitToJson: true)
class ProblemDetail {
  const ProblemDetail({
    this.type,
    this.title,
    this.status,
    this.detail,
    this.instance,
    this.properties,
  });

  factory ProblemDetail.fromJson(Map<String, dynamic> json) =>
      _$ProblemDetailFromJson(json);

  static const toJsonFactory = _$ProblemDetailToJson;
  Map<String, dynamic> toJson() => _$ProblemDetailToJson(this);

  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'detail')
  final String? detail;
  @JsonKey(name: 'instance')
  final String? instance;
  @JsonKey(name: 'properties')
  final Map<String, dynamic>? properties;
  static const fromJsonFactory = _$ProblemDetailFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ProblemDetail &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.detail, detail) ||
                const DeepCollectionEquality().equals(other.detail, detail)) &&
            (identical(other.instance, instance) ||
                const DeepCollectionEquality()
                    .equals(other.instance, instance)) &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(detail) ^
      const DeepCollectionEquality().hash(instance) ^
      const DeepCollectionEquality().hash(properties) ^
      runtimeType.hashCode;
}

extension $ProblemDetailExtension on ProblemDetail {
  ProblemDetail copyWith(
      {String? type,
      String? title,
      int? status,
      String? detail,
      String? instance,
      Map<String, dynamic>? properties}) {
    return ProblemDetail(
        type: type ?? this.type,
        title: title ?? this.title,
        status: status ?? this.status,
        detail: detail ?? this.detail,
        instance: instance ?? this.instance,
        properties: properties ?? this.properties);
  }

  ProblemDetail copyWithWrapped(
      {Wrapped<String?>? type,
      Wrapped<String?>? title,
      Wrapped<int?>? status,
      Wrapped<String?>? detail,
      Wrapped<String?>? instance,
      Wrapped<Map<String, dynamic>?>? properties}) {
    return ProblemDetail(
        type: (type != null ? type.value : this.type),
        title: (title != null ? title.value : this.title),
        status: (status != null ? status.value : this.status),
        detail: (detail != null ? detail.value : this.detail),
        instance: (instance != null ? instance.value : this.instance),
        properties: (properties != null ? properties.value : this.properties));
  }
}

@JsonSerializable(explicitToJson: true)
class TagDto {
  const TagDto({
    required this.id,
    required this.name,
  });

  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);

  static const toJsonFactory = _$TagDtoToJson;
  Map<String, dynamic> toJson() => _$TagDtoToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$TagDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TagDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $TagDtoExtension on TagDto {
  TagDto copyWith({int? id, String? name}) {
    return TagDto(id: id ?? this.id, name: name ?? this.name);
  }

  TagDto copyWithWrapped({Wrapped<int>? id, Wrapped<String>? name}) {
    return TagDto(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class EventForm {
  const EventForm({
    required this.location,
    required this.description,
    this.casualties,
    required this.deadly,
    required this.tagIds,
  });

  factory EventForm.fromJson(Map<String, dynamic> json) =>
      _$EventFormFromJson(json);

  static const toJsonFactory = _$EventFormToJson;
  Map<String, dynamic> toJson() => _$EventFormToJson(this);

  @JsonKey(name: 'location')
  final Location location;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'casualties')
  final bool? casualties;
  @JsonKey(name: 'deadly')
  final bool deadly;
  @JsonKey(name: 'tagIds', defaultValue: <int>[])
  final List<int> tagIds;
  static const fromJsonFactory = _$EventFormFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventForm &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.casualties, casualties) ||
                const DeepCollectionEquality()
                    .equals(other.casualties, casualties)) &&
            (identical(other.deadly, deadly) ||
                const DeepCollectionEquality().equals(other.deadly, deadly)) &&
            (identical(other.tagIds, tagIds) ||
                const DeepCollectionEquality().equals(other.tagIds, tagIds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(casualties) ^
      const DeepCollectionEquality().hash(deadly) ^
      const DeepCollectionEquality().hash(tagIds) ^
      runtimeType.hashCode;
}

extension $EventFormExtension on EventForm {
  EventForm copyWith(
      {Location? location,
      String? description,
      bool? casualties,
      bool? deadly,
      List<int>? tagIds}) {
    return EventForm(
        location: location ?? this.location,
        description: description ?? this.description,
        casualties: casualties ?? this.casualties,
        deadly: deadly ?? this.deadly,
        tagIds: tagIds ?? this.tagIds);
  }

  EventForm copyWithWrapped(
      {Wrapped<Location>? location,
      Wrapped<String>? description,
      Wrapped<bool?>? casualties,
      Wrapped<bool>? deadly,
      Wrapped<List<int>>? tagIds}) {
    return EventForm(
        location: (location != null ? location.value : this.location),
        description:
            (description != null ? description.value : this.description),
        casualties: (casualties != null ? casualties.value : this.casualties),
        deadly: (deadly != null ? deadly.value : this.deadly),
        tagIds: (tagIds != null ? tagIds.value : this.tagIds));
  }
}

@JsonSerializable(explicitToJson: true)
class Location {
  const Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static const toJsonFactory = _$LocationToJson;
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;
  static const fromJsonFactory = _$LocationFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Location &&
            (identical(other.latitude, latitude) ||
                const DeepCollectionEquality()
                    .equals(other.latitude, latitude)) &&
            (identical(other.longitude, longitude) ||
                const DeepCollectionEquality()
                    .equals(other.longitude, longitude)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(latitude) ^
      const DeepCollectionEquality().hash(longitude) ^
      runtimeType.hashCode;
}

extension $LocationExtension on Location {
  Location copyWith({double? latitude, double? longitude}) {
    return Location(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }

  Location copyWithWrapped(
      {Wrapped<double>? latitude, Wrapped<double>? longitude}) {
    return Location(
        latitude: (latitude != null ? latitude.value : this.latitude),
        longitude: (longitude != null ? longitude.value : this.longitude));
  }
}

@JsonSerializable(explicitToJson: true)
class EventDto {
  const EventDto({
    required this.id,
    required this.location,
    required this.description,
    this.casualties,
    required this.deadly,
    required this.time,
    required this.userDto,
    required this.hasImage,
    this.imageUrl,
    required this.tags,
  });

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);

  static const toJsonFactory = _$EventDtoToJson;
  Map<String, dynamic> toJson() => _$EventDtoToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'location')
  final Location location;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'casualties')
  final bool? casualties;
  @JsonKey(name: 'deadly')
  final bool deadly;
  @JsonKey(name: 'time')
  final DateTime time;
  @JsonKey(name: 'userDto')
  final UserDto userDto;
  @JsonKey(name: 'hasImage')
  final bool hasImage;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'tags', defaultValue: <TagDto>[])
  final List<TagDto> tags;
  static const fromJsonFactory = _$EventDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.casualties, casualties) ||
                const DeepCollectionEquality()
                    .equals(other.casualties, casualties)) &&
            (identical(other.deadly, deadly) ||
                const DeepCollectionEquality().equals(other.deadly, deadly)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.userDto, userDto) ||
                const DeepCollectionEquality()
                    .equals(other.userDto, userDto)) &&
            (identical(other.hasImage, hasImage) ||
                const DeepCollectionEquality()
                    .equals(other.hasImage, hasImage)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(casualties) ^
      const DeepCollectionEquality().hash(deadly) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(userDto) ^
      const DeepCollectionEquality().hash(hasImage) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(tags) ^
      runtimeType.hashCode;
}

extension $EventDtoExtension on EventDto {
  EventDto copyWith(
      {int? id,
      Location? location,
      String? description,
      bool? casualties,
      bool? deadly,
      DateTime? time,
      UserDto? userDto,
      bool? hasImage,
      String? imageUrl,
      List<TagDto>? tags}) {
    return EventDto(
        id: id ?? this.id,
        location: location ?? this.location,
        description: description ?? this.description,
        casualties: casualties ?? this.casualties,
        deadly: deadly ?? this.deadly,
        time: time ?? this.time,
        userDto: userDto ?? this.userDto,
        hasImage: hasImage ?? this.hasImage,
        imageUrl: imageUrl ?? this.imageUrl,
        tags: tags ?? this.tags);
  }

  EventDto copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<Location>? location,
      Wrapped<String>? description,
      Wrapped<bool?>? casualties,
      Wrapped<bool>? deadly,
      Wrapped<DateTime>? time,
      Wrapped<UserDto>? userDto,
      Wrapped<bool>? hasImage,
      Wrapped<String?>? imageUrl,
      Wrapped<List<TagDto>>? tags}) {
    return EventDto(
        id: (id != null ? id.value : this.id),
        location: (location != null ? location.value : this.location),
        description:
            (description != null ? description.value : this.description),
        casualties: (casualties != null ? casualties.value : this.casualties),
        deadly: (deadly != null ? deadly.value : this.deadly),
        time: (time != null ? time.value : this.time),
        userDto: (userDto != null ? userDto.value : this.userDto),
        hasImage: (hasImage != null ? hasImage.value : this.hasImage),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        tags: (tags != null ? tags.value : this.tags));
  }
}

@JsonSerializable(explicitToJson: true)
class UserDto {
  const UserDto({
    required this.id,
    required this.username,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  static const toJsonFactory = _$UserDtoToJson;
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'username')
  final String username;
  static const fromJsonFactory = _$UserDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      runtimeType.hashCode;
}

extension $UserDtoExtension on UserDto {
  UserDto copyWith({String? id, String? username}) {
    return UserDto(id: id ?? this.id, username: username ?? this.username);
  }

  UserDto copyWithWrapped({Wrapped<String>? id, Wrapped<String>? username}) {
    return UserDto(
        id: (id != null ? id.value : this.id),
        username: (username != null ? username.value : this.username));
  }
}

@JsonSerializable(explicitToJson: true)
class UserForm {
  const UserForm({
    required this.username,
    required this.password,
  });

  factory UserForm.fromJson(Map<String, dynamic> json) =>
      _$UserFormFromJson(json);

  static const toJsonFactory = _$UserFormToJson;
  Map<String, dynamic> toJson() => _$UserFormToJson(this);

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;
  static const fromJsonFactory = _$UserFormFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserForm &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $UserFormExtension on UserForm {
  UserForm copyWith({String? username, String? password}) {
    return UserForm(
        username: username ?? this.username,
        password: password ?? this.password);
  }

  UserForm copyWithWrapped(
      {Wrapped<String>? username, Wrapped<String>? password}) {
    return UserForm(
        username: (username != null ? username.value : this.username),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  const LoginResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  static const toJsonFactory = _$LoginResponseToJson;
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @JsonKey(name: 'user')
  final UserDto user;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  static const fromJsonFactory = _$LoginResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoginResponse &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      runtimeType.hashCode;
}

extension $LoginResponseExtension on LoginResponse {
  LoginResponse copyWith(
      {UserDto? user, String? accessToken, String? refreshToken}) {
    return LoginResponse(
        user: user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken);
  }

  LoginResponse copyWithWrapped(
      {Wrapped<UserDto>? user,
      Wrapped<String>? accessToken,
      Wrapped<String>? refreshToken}) {
    return LoginResponse(
        user: (user != null ? user.value : this.user),
        accessToken:
            (accessToken != null ? accessToken.value : this.accessToken),
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken));
  }
}

@JsonSerializable(explicitToJson: true)
class PageTagDto {
  const PageTagDto({
    this.totalPages,
    this.totalElements,
    this.pageable,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.last,
    this.empty,
  });

  factory PageTagDto.fromJson(Map<String, dynamic> json) =>
      _$PageTagDtoFromJson(json);

  static const toJsonFactory = _$PageTagDtoToJson;
  Map<String, dynamic> toJson() => _$PageTagDtoToJson(this);

  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'totalElements')
  final int? totalElements;
  @JsonKey(name: 'pageable')
  final PageableObject? pageable;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'content', defaultValue: <TagDto>[])
  final List<TagDto>? content;
  @JsonKey(name: 'number')
  final int? number;
  @JsonKey(name: 'sort')
  final SortObject? sort;
  @JsonKey(name: 'numberOfElements')
  final int? numberOfElements;
  @JsonKey(name: 'first')
  final bool? first;
  @JsonKey(name: 'last')
  final bool? last;
  @JsonKey(name: 'empty')
  final bool? empty;
  static const fromJsonFactory = _$PageTagDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PageTagDto &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality()
                    .equals(other.totalPages, totalPages)) &&
            (identical(other.totalElements, totalElements) ||
                const DeepCollectionEquality()
                    .equals(other.totalElements, totalElements)) &&
            (identical(other.pageable, pageable) ||
                const DeepCollectionEquality()
                    .equals(other.pageable, pageable)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.numberOfElements, numberOfElements) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfElements, numberOfElements)) &&
            (identical(other.first, first) ||
                const DeepCollectionEquality().equals(other.first, first)) &&
            (identical(other.last, last) ||
                const DeepCollectionEquality().equals(other.last, last)) &&
            (identical(other.empty, empty) ||
                const DeepCollectionEquality().equals(other.empty, empty)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalElements) ^
      const DeepCollectionEquality().hash(pageable) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(number) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(numberOfElements) ^
      const DeepCollectionEquality().hash(first) ^
      const DeepCollectionEquality().hash(last) ^
      const DeepCollectionEquality().hash(empty) ^
      runtimeType.hashCode;
}

extension $PageTagDtoExtension on PageTagDto {
  PageTagDto copyWith(
      {int? totalPages,
      int? totalElements,
      PageableObject? pageable,
      int? size,
      List<TagDto>? content,
      int? number,
      SortObject? sort,
      int? numberOfElements,
      bool? first,
      bool? last,
      bool? empty}) {
    return PageTagDto(
        totalPages: totalPages ?? this.totalPages,
        totalElements: totalElements ?? this.totalElements,
        pageable: pageable ?? this.pageable,
        size: size ?? this.size,
        content: content ?? this.content,
        number: number ?? this.number,
        sort: sort ?? this.sort,
        numberOfElements: numberOfElements ?? this.numberOfElements,
        first: first ?? this.first,
        last: last ?? this.last,
        empty: empty ?? this.empty);
  }

  PageTagDto copyWithWrapped(
      {Wrapped<int?>? totalPages,
      Wrapped<int?>? totalElements,
      Wrapped<PageableObject?>? pageable,
      Wrapped<int?>? size,
      Wrapped<List<TagDto>?>? content,
      Wrapped<int?>? number,
      Wrapped<SortObject?>? sort,
      Wrapped<int?>? numberOfElements,
      Wrapped<bool?>? first,
      Wrapped<bool?>? last,
      Wrapped<bool?>? empty}) {
    return PageTagDto(
        totalPages: (totalPages != null ? totalPages.value : this.totalPages),
        totalElements:
            (totalElements != null ? totalElements.value : this.totalElements),
        pageable: (pageable != null ? pageable.value : this.pageable),
        size: (size != null ? size.value : this.size),
        content: (content != null ? content.value : this.content),
        number: (number != null ? number.value : this.number),
        sort: (sort != null ? sort.value : this.sort),
        numberOfElements: (numberOfElements != null
            ? numberOfElements.value
            : this.numberOfElements),
        first: (first != null ? first.value : this.first),
        last: (last != null ? last.value : this.last),
        empty: (empty != null ? empty.value : this.empty));
  }
}

@JsonSerializable(explicitToJson: true)
class PageableObject {
  const PageableObject({
    this.pageNumber,
    this.pageSize,
    this.offset,
    this.sort,
    this.paged,
    this.unpaged,
  });

  factory PageableObject.fromJson(Map<String, dynamic> json) =>
      _$PageableObjectFromJson(json);

  static const toJsonFactory = _$PageableObjectToJson;
  Map<String, dynamic> toJson() => _$PageableObjectToJson(this);

  @JsonKey(name: 'pageNumber')
  final int? pageNumber;
  @JsonKey(name: 'pageSize')
  final int? pageSize;
  @JsonKey(name: 'offset')
  final int? offset;
  @JsonKey(name: 'sort')
  final SortObject? sort;
  @JsonKey(name: 'paged')
  final bool? paged;
  @JsonKey(name: 'unpaged')
  final bool? unpaged;
  static const fromJsonFactory = _$PageableObjectFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PageableObject &&
            (identical(other.pageNumber, pageNumber) ||
                const DeepCollectionEquality()
                    .equals(other.pageNumber, pageNumber)) &&
            (identical(other.pageSize, pageSize) ||
                const DeepCollectionEquality()
                    .equals(other.pageSize, pageSize)) &&
            (identical(other.offset, offset) ||
                const DeepCollectionEquality().equals(other.offset, offset)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.paged, paged) ||
                const DeepCollectionEquality().equals(other.paged, paged)) &&
            (identical(other.unpaged, unpaged) ||
                const DeepCollectionEquality().equals(other.unpaged, unpaged)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pageNumber) ^
      const DeepCollectionEquality().hash(pageSize) ^
      const DeepCollectionEquality().hash(offset) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(paged) ^
      const DeepCollectionEquality().hash(unpaged) ^
      runtimeType.hashCode;
}

extension $PageableObjectExtension on PageableObject {
  PageableObject copyWith(
      {int? pageNumber,
      int? pageSize,
      int? offset,
      SortObject? sort,
      bool? paged,
      bool? unpaged}) {
    return PageableObject(
        pageNumber: pageNumber ?? this.pageNumber,
        pageSize: pageSize ?? this.pageSize,
        offset: offset ?? this.offset,
        sort: sort ?? this.sort,
        paged: paged ?? this.paged,
        unpaged: unpaged ?? this.unpaged);
  }

  PageableObject copyWithWrapped(
      {Wrapped<int?>? pageNumber,
      Wrapped<int?>? pageSize,
      Wrapped<int?>? offset,
      Wrapped<SortObject?>? sort,
      Wrapped<bool?>? paged,
      Wrapped<bool?>? unpaged}) {
    return PageableObject(
        pageNumber: (pageNumber != null ? pageNumber.value : this.pageNumber),
        pageSize: (pageSize != null ? pageSize.value : this.pageSize),
        offset: (offset != null ? offset.value : this.offset),
        sort: (sort != null ? sort.value : this.sort),
        paged: (paged != null ? paged.value : this.paged),
        unpaged: (unpaged != null ? unpaged.value : this.unpaged));
  }
}

@JsonSerializable(explicitToJson: true)
class SortObject {
  const SortObject({
    this.sorted,
    this.empty,
    this.unsorted,
  });

  factory SortObject.fromJson(Map<String, dynamic> json) =>
      _$SortObjectFromJson(json);

  static const toJsonFactory = _$SortObjectToJson;
  Map<String, dynamic> toJson() => _$SortObjectToJson(this);

  @JsonKey(name: 'sorted')
  final bool? sorted;
  @JsonKey(name: 'empty')
  final bool? empty;
  @JsonKey(name: 'unsorted')
  final bool? unsorted;
  static const fromJsonFactory = _$SortObjectFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SortObject &&
            (identical(other.sorted, sorted) ||
                const DeepCollectionEquality().equals(other.sorted, sorted)) &&
            (identical(other.empty, empty) ||
                const DeepCollectionEquality().equals(other.empty, empty)) &&
            (identical(other.unsorted, unsorted) ||
                const DeepCollectionEquality()
                    .equals(other.unsorted, unsorted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sorted) ^
      const DeepCollectionEquality().hash(empty) ^
      const DeepCollectionEquality().hash(unsorted) ^
      runtimeType.hashCode;
}

extension $SortObjectExtension on SortObject {
  SortObject copyWith({bool? sorted, bool? empty, bool? unsorted}) {
    return SortObject(
        sorted: sorted ?? this.sorted,
        empty: empty ?? this.empty,
        unsorted: unsorted ?? this.unsorted);
  }

  SortObject copyWithWrapped(
      {Wrapped<bool?>? sorted,
      Wrapped<bool?>? empty,
      Wrapped<bool?>? unsorted}) {
    return SortObject(
        sorted: (sorted != null ? sorted.value : this.sorted),
        empty: (empty != null ? empty.value : this.empty),
        unsorted: (unsorted != null ? unsorted.value : this.unsorted));
  }
}

@JsonSerializable(explicitToJson: true)
class PageEventDto {
  const PageEventDto({
    this.totalPages,
    this.totalElements,
    this.pageable,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.last,
    this.empty,
  });

  factory PageEventDto.fromJson(Map<String, dynamic> json) =>
      _$PageEventDtoFromJson(json);

  static const toJsonFactory = _$PageEventDtoToJson;
  Map<String, dynamic> toJson() => _$PageEventDtoToJson(this);

  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'totalElements')
  final int? totalElements;
  @JsonKey(name: 'pageable')
  final PageableObject? pageable;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'content', defaultValue: <EventDto>[])
  final List<EventDto>? content;
  @JsonKey(name: 'number')
  final int? number;
  @JsonKey(name: 'sort')
  final SortObject? sort;
  @JsonKey(name: 'numberOfElements')
  final int? numberOfElements;
  @JsonKey(name: 'first')
  final bool? first;
  @JsonKey(name: 'last')
  final bool? last;
  @JsonKey(name: 'empty')
  final bool? empty;
  static const fromJsonFactory = _$PageEventDtoFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PageEventDto &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality()
                    .equals(other.totalPages, totalPages)) &&
            (identical(other.totalElements, totalElements) ||
                const DeepCollectionEquality()
                    .equals(other.totalElements, totalElements)) &&
            (identical(other.pageable, pageable) ||
                const DeepCollectionEquality()
                    .equals(other.pageable, pageable)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.numberOfElements, numberOfElements) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfElements, numberOfElements)) &&
            (identical(other.first, first) ||
                const DeepCollectionEquality().equals(other.first, first)) &&
            (identical(other.last, last) ||
                const DeepCollectionEquality().equals(other.last, last)) &&
            (identical(other.empty, empty) ||
                const DeepCollectionEquality().equals(other.empty, empty)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalElements) ^
      const DeepCollectionEquality().hash(pageable) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(number) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(numberOfElements) ^
      const DeepCollectionEquality().hash(first) ^
      const DeepCollectionEquality().hash(last) ^
      const DeepCollectionEquality().hash(empty) ^
      runtimeType.hashCode;
}

extension $PageEventDtoExtension on PageEventDto {
  PageEventDto copyWith(
      {int? totalPages,
      int? totalElements,
      PageableObject? pageable,
      int? size,
      List<EventDto>? content,
      int? number,
      SortObject? sort,
      int? numberOfElements,
      bool? first,
      bool? last,
      bool? empty}) {
    return PageEventDto(
        totalPages: totalPages ?? this.totalPages,
        totalElements: totalElements ?? this.totalElements,
        pageable: pageable ?? this.pageable,
        size: size ?? this.size,
        content: content ?? this.content,
        number: number ?? this.number,
        sort: sort ?? this.sort,
        numberOfElements: numberOfElements ?? this.numberOfElements,
        first: first ?? this.first,
        last: last ?? this.last,
        empty: empty ?? this.empty);
  }

  PageEventDto copyWithWrapped(
      {Wrapped<int?>? totalPages,
      Wrapped<int?>? totalElements,
      Wrapped<PageableObject?>? pageable,
      Wrapped<int?>? size,
      Wrapped<List<EventDto>?>? content,
      Wrapped<int?>? number,
      Wrapped<SortObject?>? sort,
      Wrapped<int?>? numberOfElements,
      Wrapped<bool?>? first,
      Wrapped<bool?>? last,
      Wrapped<bool?>? empty}) {
    return PageEventDto(
        totalPages: (totalPages != null ? totalPages.value : this.totalPages),
        totalElements:
            (totalElements != null ? totalElements.value : this.totalElements),
        pageable: (pageable != null ? pageable.value : this.pageable),
        size: (size != null ? size.value : this.size),
        content: (content != null ? content.value : this.content),
        number: (number != null ? number.value : this.number),
        sort: (sort != null ? sort.value : this.sort),
        numberOfElements: (numberOfElements != null
            ? numberOfElements.value
            : this.numberOfElements),
        first: (first != null ? first.value : this.first),
        last: (last != null ? last.value : this.last),
        empty: (empty != null ? empty.value : this.empty));
  }
}

@JsonSerializable(explicitToJson: true)
class EventsEventIdImgPost$RequestBody {
  const EventsEventIdImgPost$RequestBody({
    required this.file,
  });

  factory EventsEventIdImgPost$RequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$EventsEventIdImgPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$EventsEventIdImgPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$EventsEventIdImgPost$RequestBodyToJson(this);

  @JsonKey(name: 'file')
  final String file;
  static const fromJsonFactory = _$EventsEventIdImgPost$RequestBodyFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventsEventIdImgPost$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $EventsEventIdImgPost$RequestBodyExtension
    on EventsEventIdImgPost$RequestBody {
  EventsEventIdImgPost$RequestBody copyWith({String? file}) {
    return EventsEventIdImgPost$RequestBody(file: file ?? this.file);
  }

  EventsEventIdImgPost$RequestBody copyWithWrapped({Wrapped<String>? file}) {
    return EventsEventIdImgPost$RequestBody(
        file: (file != null ? file.value : this.file));
  }
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
