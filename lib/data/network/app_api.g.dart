// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _AppServiceClient implements AppServiceClient {
  _AppServiceClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://fota2022.herokuapp.com/api/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthenticationResponse> login(email, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationResponse> register(
      fullname, username, email, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'fullname': fullname,
      'username': username,
      'email': email,
      'password': password
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationResponse> refreshToken(refreshToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'refreshtoken': refreshToken};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/refresh_token',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyCarsResponse> getMyCars() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MyCarsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user/car/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyCarsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserDataResponse> getUserData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserDataResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserDataListResponse> searchUser(username, code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'username': username,
      r'code': code
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserDataListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserDataListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserDataResponse> updateUser(fullname, profileImage) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'fullname': fullname, 'profileImage': profileImage};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserDataResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyCarsResponse> connectCar(code, password, carType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'code': code, 'password': password, 'carType': carType};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MyCarsResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/car/connect',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyCarsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyCarsResponse> disconnectCar(code, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'code': code, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MyCarsResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/car/dissconnect',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyCarsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyCarsResponse> shareCar(userId, code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'userId': userId, 'code': code};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MyCarsResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/car/share',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyCarsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyCarsResponse> removeUserAwayMyCar(userId, code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'userId': userId, 'code': code};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MyCarsResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/car/user/remove',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyCarsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyCarsResponse> unshareCar(code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'code': code};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MyCarsResponse>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/car/unshare',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyCarsResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
