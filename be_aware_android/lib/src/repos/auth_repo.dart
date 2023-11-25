import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthRepo {
  final storage = const FlutterSecureStorage();
  final String refreshTokenKey = "REFRESH_TOKEN_KEY";

  static String? _accessToken;
  String? get accessToken => _accessToken;

  static UserDto? _loggedInUser;
  UserDto? get loggedInUser => _loggedInUser;

  Future<void> saveLoginResponse(LoginResponse response) async {
    _accessToken = response.accessToken;
    _loggedInUser = response.user;
    await storage.write(
      key: refreshTokenKey,
      value: response.refreshToken,
    );
  }

  Future<String?> getRefreshToken() {
    return storage.read(key: refreshTokenKey);
  }

  Future<void> deleteTokensFromStorage() async {
    _accessToken = null;
    _loggedInUser = null;
    await storage.delete(key: refreshTokenKey);
  }
}
