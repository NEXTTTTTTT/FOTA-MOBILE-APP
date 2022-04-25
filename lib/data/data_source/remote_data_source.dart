

import '../network/app_api.dart';
import '../request/request.dart';
import '../responses/response.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource{
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest)async {
    return await _appServiceClient.login(
      loginRequest.email,loginRequest.password,
    );
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest)async {
    return await _appServiceClient.register(
      registerRequest.fullname,registerRequest.username,registerRequest.email,registerRequest.password,
    );
  }

}