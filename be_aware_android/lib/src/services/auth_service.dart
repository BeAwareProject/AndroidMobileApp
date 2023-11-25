import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/exceptions/server_exception.dart';
import 'package:be_aware_android/src/exceptions/unauthorized_exception.dart';
import 'package:be_aware_android/src/exceptions/user_already_exists_exception.dart';
import 'package:be_aware_android/src/repos/auth_repo.dart';
import 'package:be_aware_android/src/services/api.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  AuthService(
    this._api,
    this._authRepo,
  );

  final Api _api;
  final AuthRepo _authRepo;

  Future<LoginResponse> login(UserForm userLoginForm) async {
    Response<LoginResponse> response =
        await _api.noAuthClient.authLoginPost(body: userLoginForm);
    if (response.statusCode == 201) {
      await _authRepo.saveLoginResponse(response.body!);
      return response.body!;
    } else if (response.statusCode == 401 || response.statusCode == 400) {
      throw UnauthorizedException();
    } else {
      throw ServerException(status: response.statusCode);
    }
  }

  Future<LoginResponse> refreshAccessToken() async {
    Response<LoginResponse> response = await _api.authClient.authLoginPatch();
    if (response.statusCode == 200) {
      await _authRepo.saveLoginResponse(response.body!);
      return response.body!;
    } else if (response.statusCode == 401 || response.statusCode == 400) {
      throw UnauthorizedException();
    } else {
      throw ServerException(status: response.statusCode);
    }
  }

  Future<void> register(UserForm userRegisterForm) async {
    Response<dynamic> response =
        await _api.noAuthClient.usersPost(body: userRegisterForm);
    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 409) {
      throw UserAlreadyExistsException();
    } else {
      throw ServerException(status: response.statusCode);
    }
  }
}
