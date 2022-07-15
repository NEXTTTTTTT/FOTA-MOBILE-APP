import '../network/app_api.dart';
import '../request/request.dart';
import '../responses/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<MyCarsResponse> getMyCars();
  Future<UserDataResponse> getUserData();
  Future<AuthenticationResponse> refreshToken(String refreshToken);
  Future<UserDataListResponse> searchUser(String username, String code);
  Future<UserDataResponse> updateUser(String fullname, String profileImage);
  Future<MyCarsResponse> connectCar(String code, String password,String carName);
  Future<MyCarsResponse> disconnectCar(String code, String password);
  Future<MyCarsResponse> shareCar(String userId, String code);
  Future<MyCarsResponse> removeUserAwayMyCar(String userId, String code);
  Future<MyCarsResponse> unshareCar(String code);
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
  Future<MyCarsResponse> getMyCars() async {
    return await _appServiceClient.getMyCars();
  }

  @override
  Future<UserDataResponse> getUserData() async {
    return await _appServiceClient.getUserData();
  }

  @override
  Future<AuthenticationResponse> refreshToken(refreshToken) async {
    return await _appServiceClient.refreshToken(refreshToken);
  }

  @override
  Future<MyCarsResponse> connectCar(String code, String password, String carName) async {
    return await _appServiceClient.connectCar(code, password,carName);
  }

  @override
  Future<MyCarsResponse> disconnectCar(String code, String password) async {
    return await _appServiceClient.disconnectCar(code, password);
  }

  @override
  Future<MyCarsResponse> removeUserAwayMyCar(
      String userId, String code) async {
    return await _appServiceClient.removeUserAwayMyCar(userId, code);
  }

  @override
  Future<UserDataListResponse> searchUser(String username, String code) async {
    return await _appServiceClient.searchUser(username,code);
  }

  @override
  Future<MyCarsResponse> shareCar(String userId, String code) async{
    return await _appServiceClient.shareCar(userId, code);
  }

  @override
  Future<MyCarsResponse> unshareCar(String code) async {
    return await _appServiceClient.unshareCar(code);
  }

  @override
  Future<UserDataResponse> updateUser(String fullname, String profileImage)async {
    return await _appServiceClient.updateUser(fullname, profileImage);
  }
}
