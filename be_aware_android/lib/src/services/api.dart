import 'dart:async';
import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/exceptions/unauthorized_exception.dart';
import 'package:be_aware_android/src/repos/auth_repo.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

@injectable
class Api {
  Api(this._authRepo);
  final AuthRepo _authRepo;
  static const String _baseUrl = "https://beawareproject.com/api/";

  ApiSpec get authClient => ApiSpec.create(
        client: ChopperClient(
          baseUrl: Uri.parse(_baseUrl),
          services: [
            ApiSpec.create(),
          ],
          interceptors: [
            _AuthInterceptor(_authRepo),
          ],
          converter: $JsonSerializableConverter(),
        ),
      );

  final ApiSpec _noAuthClient = ApiSpec.create(
    baseUrl: Uri.parse(Api._baseUrl),
  );

  ApiSpec get noAuthClient => _noAuthClient;
}

class _AuthInterceptor implements RequestInterceptor {
  _AuthInterceptor(this._authRepo);
  final AuthRepo _authRepo;

  @override
  FutureOr<Request> onRequest(Request request) async {
    if (request.url.toString().contains("/auth/login")) {
      String? refreshToken = await _authRepo.getRefreshToken();
      if (refreshToken != null) {
        return applyHeader(
          request,
          'Authorization',
          'Bearer $refreshToken',
        );
      } else {
        throw UnauthorizedException();
      }
    } else {
      if (_authRepo.accessToken != null) {
        return applyHeader(
          request,
          'Authorization',
          'Bearer ${_authRepo.accessToken}',
        );
      } else {
        throw UnauthorizedException();
      }
    }
  }
}
