import 'package:dio/dio.dart';

import 'package:retrofit/http.dart';

import '../../app/constants.dart';
import '../../domain/model/model.dart';
import '../responses/response.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  //* Authentication
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

  @POST("/refresh_token")
  Future<AuthenticationResponse> refreshToken(
    @Field("refreshtoken") String refreshToken,
  );

  //* User
  @GET("/user/car/")
  Future<MyCarsResponse> getMyCars();

  @GET("/user/")
  Future<UserDataResponse> getUserData();

  @GET("/search")
  Future<UserDataListResponse> searchUser(
    @Query("username") String username,
    @Query("code") String code,
  );

  @PATCH("/user")
  Future<UserDataResponse> updateUser(
    @Field() String fullname,
    @Field() String profileImage,
    @Field() String deviceToken,
  );

//* Car
  @PATCH("/car/connect")
  Future<MyCarsResponse> connectCar(
    @Field() String code,
    @Field() String password,
    @Field() String carType,
  );
  @PATCH("/car/dissconnect")
  Future<MyCarsResponse> disconnectCar(
    @Field() String code,
    @Field() String password,
  );

  @PATCH("/car/share")
  Future<MyCarsResponse> shareCar(
    @Field() String userId,
    @Field() String code,
  );

  @PATCH("/car/user/remove")
  Future<MyCarsResponse> removeUserAwayMyCar(
    @Field() String userId,
    @Field() String code,
  );

  @PATCH("/car/unshare")
  Future<MyCarsResponse> unshareCar(
    @Field() String code,
  );

  //* Notification
  @GET("/notify/all")
  Future<NotifyListResponse> getNotifys();

  @PATCH("/notify/{id}/read")
  Future<BaseResponse> readNotify(
    @Path("id") String id,
  );
}
