import '../network/app_api.dart';
import '../request/request.dart';
import '../responses/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<MyCarsResponse> getMyCars(String id);
  Future<UserDataResponse> getUserData(String id);
  Future<AuthenticationResponse> refreshToken(String refreshToken);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.fullname,
      registerRequest.username,
      registerRequest.email,
      registerRequest.password,
    );
  }

  @override
  Future<MyCarsResponse> getMyCars(id) async {
    return await _appServiceClient.getMyCars(id);
  }

  @override
  Future<UserDataResponse> getUserData(String id) async {
    return await _appServiceClient.getUserData(id);
  }

  @override
  Future<AuthenticationResponse> refreshToken(refreshToken) async {
    return await _appServiceClient.refreshToken(refreshToken);
  }
}
