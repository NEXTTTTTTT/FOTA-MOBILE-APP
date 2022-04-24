import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "msg")
  String? msg;

}

@JsonSerializable()
class UserResponse{
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
  
  UserResponse(this.id,this.fullname,this.email,this.profileImage,this.deviceToken,this.isActive,this.currentLocation,this.createdAt);
  // from json
  factory UserResponse.fromJson(Map<String,dynamic> json)=> _$UserResponseFromJson(json);
  // to json
  Map<String,dynamic> toJson() =>_$UserResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name:"access_token")
  String? accessToken;
  @JsonKey(name: "user")
  UserResponse? user;

  AuthenticationResponse(this.accessToken,this.user);
  // from json
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=> _$AuthenticationResponseFromJson(json);
  // to json
  Map<String,dynamic> toJson() =>_$AuthenticationResponseToJson(this);
}