import 'package:dio/dio.dart';

import 'package:retrofit/http.dart';

import '../../app/constants.dart';
import '../responses/response.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

   @POST("/register")
  Future<AuthenticationResponse> register(
    @Field("fullname") String fullname,
    @Field("username") String username,
    @Field("email") String email,
    @Field("password") String password,
  );

  
}
