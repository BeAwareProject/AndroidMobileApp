import 'dart:async';
import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

@singleton
class Api {
  static const String _baseUrl = "https://beawareproject.com/api/";

  final ApiSpec _authClient = ApiSpec.create(
    client: ChopperClient(
      baseUrl: Uri.parse(_baseUrl),
      interceptors: [
        _AuthInterceptor(),
      ],
    ),
  );

  ApiSpec get authClient => _authClient;

  final ApiSpec _noAuthClient = ApiSpec.create(
    baseUrl: Uri.parse(Api._baseUrl),
  );

  ApiSpec get noAuthClient => _noAuthClient;
}

class _AuthInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final String authToken = "abc";
    return applyHeader(request, 'Authorization', 'Bearer $authToken');
  }
}
