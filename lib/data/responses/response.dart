import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "msg")
  String? msg;
}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "fullname")
  String? fullname;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "profileImage")
  String? profileImage;
  @JsonKey(name: "deviceToken")
  String? deviceToken;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "currentLocation")
  Map? currentLocation;
  @JsonKey(name: "createdAt")
  String? createdAt;

  UserResponse(this.id, this.fullname, this.email, this.profileImage,
      this.deviceToken, this.isActive, this.currentLocation, this.createdAt);
  // from json
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "access_token")
  String? accessToken;
  @JsonKey(name: "refresh_token")
  String? refreshToken;
  @JsonKey(name: "user")
  UserResponse? user;

  AuthenticationResponse(this.accessToken, this.user ,this.refreshToken);
  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class CarResponse {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "carType")
  String? carType;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "admin")
  UserResponse? admin;
  @JsonKey(name: "users")
  List<UserResponse>? users;
  @JsonKey(name: "defaultSpeed")
  int? defaultSpeed;
  @JsonKey(name: "currentSpeed")
  int? currentSpeed;
  @JsonKey(name: "carLocation")
  Map? carLocation;
  @JsonKey(name: "firmware")
  Map? firmware;
  @JsonKey(name: "createdAt")
  String? createdAt;

  CarResponse(
      this.id,
      this.code,
      this.carType,
      this.password,
      this.isActive,
      this.admin,
      this.users,
      this.firmware,
      this.currentSpeed,
      this.defaultSpeed,
      this.carLocation,
      this.createdAt);
  // from json
  factory CarResponse.fromJson(Map<String, dynamic> json) =>
      _$CarResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CarResponseToJson(this);
}

@JsonSerializable()
class MyCarsResponse extends BaseResponse {
  @JsonKey(name: "my_cars")
  List<CarResponse>? myCars;
  MyCarsResponse(this.myCars);
  // from json
  factory MyCarsResponse.fromJson(Map<String, dynamic> json) =>
      _$MyCarsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$MyCarsResponseToJson(this);
}

@JsonSerializable()
class UserDataResponse extends BaseResponse {
  @JsonKey(name: "user")
  UserResponse user;
  UserDataResponse(this.user);
  // from json
  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}
