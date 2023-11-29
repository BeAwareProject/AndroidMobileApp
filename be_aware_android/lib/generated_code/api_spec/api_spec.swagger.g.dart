// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_spec.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagForm _$TagFormFromJson(Map<String, dynamic> json) => TagForm(
      name: json['name'] as String,
      langtag: json['langtag'] as String,
    );

Map<String, dynamic> _$TagFormToJson(TagForm instance) => <String, dynamic>{
      'name': instance.name,
      'langtag': instance.langtag,
    };

ProblemDetail _$ProblemDetailFromJson(Map<String, dynamic> json) =>
    ProblemDetail(
      type: json['type'] as String?,
      title: json['title'] as String?,
      status: json['status'] as int?,
      detail: json['detail'] as String?,
      instance: json['instance'] as String?,
      properties: json['properties'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProblemDetailToJson(ProblemDetail instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'status': instance.status,
      'detail': instance.detail,
      'instance': instance.instance,
      'properties': instance.properties,
    };

TagDto _$TagDtoFromJson(Map<String, dynamic> json) => TagDto(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TagDtoToJson(TagDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

EventForm _$EventFormFromJson(Map<String, dynamic> json) => EventForm(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      description: json['description'] as String,
      casualties: json['casualties'] as bool?,
      deadly: json['deadly'] as bool,
      tagIds:
          (json['tagIds'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              [],
    );

Map<String, dynamic> _$EventFormToJson(EventForm instance) => <String, dynamic>{
      'location': instance.location.toJson(),
      'description': instance.description,
      'casualties': instance.casualties,
      'deadly': instance.deadly,
      'tagIds': instance.tagIds,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

EventDto _$EventDtoFromJson(Map<String, dynamic> json) => EventDto(
      id: json['id'] as int,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      description: json['description'] as String,
      casualties: json['casualties'] as bool?,
      deadly: json['deadly'] as bool,
      time: DateTime.parse(json['time'] as String),
      userDto: UserDto.fromJson(json['userDto'] as Map<String, dynamic>),
      hasImage: json['hasImage'] as bool,
      imageUrl: json['imageUrl'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => TagDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$EventDtoToJson(EventDto instance) => <String, dynamic>{
      'id': instance.id,
      'location': instance.location.toJson(),
      'description': instance.description,
      'casualties': instance.casualties,
      'deadly': instance.deadly,
      'time': instance.time.toIso8601String(),
      'userDto': instance.userDto.toJson(),
      'hasImage': instance.hasImage,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags.map((e) => e.toJson()).toList(),
    };

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
    };

UserForm _$UserFormFromJson(Map<String, dynamic> json) => UserForm(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserFormToJson(UserForm instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

StreamForm _$StreamFormFromJson(Map<String, dynamic> json) => StreamForm(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreamFormToJson(StreamForm instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
    };

StreamPublishDto _$StreamPublishDtoFromJson(Map<String, dynamic> json) =>
    StreamPublishDto(
      streamId: json['streamId'] as int,
      rtmpsPublishBasePath: json['rtmpsPublishBasePath'] as String,
      streamKey: json['streamKey'] as String,
      rtmpsPublishFullUrl: json['rtmpsPublishFullUrl'] as String,
      timeLimitForStartPublishing: json['timeLimitForStartPublishing'] == null
          ? null
          : DateTime.parse(json['timeLimitForStartPublishing'] as String),
      restartAllowed: json['restartAllowed'] as bool,
      timeLimitForRestartPublishing:
          json['timeLimitForRestartPublishing'] == null
              ? null
              : DateTime.parse(json['timeLimitForRestartPublishing'] as String),
      minBitrate: json['minBitrate'] as int,
      maxBitrate: json['maxBitrate'] as int,
      minFps: json['minFps'] as int,
      maxFps: json['maxFps'] as int,
      minResolution: json['minResolution'] as int,
      maxResolution: json['maxResolution'] as int,
    );

Map<String, dynamic> _$StreamPublishDtoToJson(StreamPublishDto instance) =>
    <String, dynamic>{
      'streamId': instance.streamId,
      'rtmpsPublishBasePath': instance.rtmpsPublishBasePath,
      'streamKey': instance.streamKey,
      'rtmpsPublishFullUrl': instance.rtmpsPublishFullUrl,
      'timeLimitForStartPublishing':
          instance.timeLimitForStartPublishing?.toIso8601String(),
      'restartAllowed': instance.restartAllowed,
      'timeLimitForRestartPublishing':
          instance.timeLimitForRestartPublishing?.toIso8601String(),
      'minBitrate': instance.minBitrate,
      'maxBitrate': instance.maxBitrate,
      'minFps': instance.minFps,
      'maxFps': instance.maxFps,
      'minResolution': instance.minResolution,
      'maxResolution': instance.maxResolution,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

PageTagDto _$PageTagDtoFromJson(Map<String, dynamic> json) => PageTagDto(
      totalPages: json['totalPages'] as int?,
      totalElements: json['totalElements'] as int?,
      pageable: json['pageable'] == null
          ? null
          : PageableObject.fromJson(json['pageable'] as Map<String, dynamic>),
      size: json['size'] as int?,
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => TagDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      number: json['number'] as int?,
      sort: json['sort'] == null
          ? null
          : SortObject.fromJson(json['sort'] as Map<String, dynamic>),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      numberOfElements: json['numberOfElements'] as int?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$PageTagDtoToJson(PageTagDto instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'pageable': instance.pageable?.toJson(),
      'size': instance.size,
      'content': instance.content?.map((e) => e.toJson()).toList(),
      'number': instance.number,
      'sort': instance.sort?.toJson(),
      'first': instance.first,
      'last': instance.last,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
    };

PageableObject _$PageableObjectFromJson(Map<String, dynamic> json) =>
    PageableObject(
      pageNumber: json['pageNumber'] as int?,
      pageSize: json['pageSize'] as int?,
      offset: json['offset'] as int?,
      sort: json['sort'] == null
          ? null
          : SortObject.fromJson(json['sort'] as Map<String, dynamic>),
      paged: json['paged'] as bool?,
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$PageableObjectToJson(PageableObject instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'offset': instance.offset,
      'sort': instance.sort?.toJson(),
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };

SortObject _$SortObjectFromJson(Map<String, dynamic> json) => SortObject(
      sorted: json['sorted'] as bool?,
      empty: json['empty'] as bool?,
      unsorted: json['unsorted'] as bool?,
    );

Map<String, dynamic> _$SortObjectToJson(SortObject instance) =>
    <String, dynamic>{
      'sorted': instance.sorted,
      'empty': instance.empty,
      'unsorted': instance.unsorted,
    };

PageStreamDto _$PageStreamDtoFromJson(Map<String, dynamic> json) =>
    PageStreamDto(
      totalPages: json['totalPages'] as int?,
      totalElements: json['totalElements'] as int?,
      pageable: json['pageable'] == null
          ? null
          : PageableObject.fromJson(json['pageable'] as Map<String, dynamic>),
      size: json['size'] as int?,
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => StreamDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      number: json['number'] as int?,
      sort: json['sort'] == null
          ? null
          : SortObject.fromJson(json['sort'] as Map<String, dynamic>),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      numberOfElements: json['numberOfElements'] as int?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$PageStreamDtoToJson(PageStreamDto instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'pageable': instance.pageable?.toJson(),
      'size': instance.size,
      'content': instance.content?.map((e) => e.toJson()).toList(),
      'number': instance.number,
      'sort': instance.sort?.toJson(),
      'first': instance.first,
      'last': instance.last,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
    };

StreamDto _$StreamDtoFromJson(Map<String, dynamic> json) => StreamDto(
      id: json['id'] as int,
      createdLocation:
          Location.fromJson(json['createdLocation'] as Map<String, dynamic>),
      createdTime: DateTime.parse(json['createdTime'] as String),
      userDto: UserDto.fromJson(json['userDto'] as Map<String, dynamic>),
      streamPlayDto:
          StreamPlayDto.fromJson(json['streamPlayDto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreamDtoToJson(StreamDto instance) => <String, dynamic>{
      'id': instance.id,
      'createdLocation': instance.createdLocation.toJson(),
      'createdTime': instance.createdTime.toIso8601String(),
      'userDto': instance.userDto.toJson(),
      'streamPlayDto': instance.streamPlayDto.toJson(),
    };

StreamPlayDto _$StreamPlayDtoFromJson(Map<String, dynamic> json) =>
    StreamPlayDto(
      streamId: json['streamId'] as int,
      hlsPlayBasePath: json['hlsPlayBasePath'] as String,
      streamKey: json['streamKey'] as String,
      hlsPlayFullUrl: json['hlsPlayFullUrl'] as String,
    );

Map<String, dynamic> _$StreamPlayDtoToJson(StreamPlayDto instance) =>
    <String, dynamic>{
      'streamId': instance.streamId,
      'hlsPlayBasePath': instance.hlsPlayBasePath,
      'streamKey': instance.streamKey,
      'hlsPlayFullUrl': instance.hlsPlayFullUrl,
    };

PageEventDto _$PageEventDtoFromJson(Map<String, dynamic> json) => PageEventDto(
      totalPages: json['totalPages'] as int?,
      totalElements: json['totalElements'] as int?,
      pageable: json['pageable'] == null
          ? null
          : PageableObject.fromJson(json['pageable'] as Map<String, dynamic>),
      size: json['size'] as int?,
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => EventDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      number: json['number'] as int?,
      sort: json['sort'] == null
          ? null
          : SortObject.fromJson(json['sort'] as Map<String, dynamic>),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      numberOfElements: json['numberOfElements'] as int?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$PageEventDtoToJson(PageEventDto instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'pageable': instance.pageable?.toJson(),
      'size': instance.size,
      'content': instance.content?.map((e) => e.toJson()).toList(),
      'number': instance.number,
      'sort': instance.sort?.toJson(),
      'first': instance.first,
      'last': instance.last,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
    };

EventsEventIdImgPost$RequestBody _$EventsEventIdImgPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    EventsEventIdImgPost$RequestBody(
      file: json['file'] as String,
    );

Map<String, dynamic> _$EventsEventIdImgPost$RequestBodyToJson(
        EventsEventIdImgPost$RequestBody instance) =>
    <String, dynamic>{
      'file': instance.file,
    };
