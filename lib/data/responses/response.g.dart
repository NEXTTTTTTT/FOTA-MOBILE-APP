// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as int?
  ..msg = json['msg'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['_id'] as String?,
      json['fullname'] as String?,
      json['email'] as String?,
      json['profileImage'] as String?,
      json['deviceToken'] as String?,
      json['isActive'] as bool?,
      json['currentLocation'] as Map<String, dynamic>?,
      json['createdAt'] as String?,
    )..username = json['username'] as String?;

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'username': instance.username,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'deviceToken': instance.deviceToken,
      'isActive': instance.isActive,
      'currentLocation': instance.currentLocation,
      'createdAt': instance.createdAt,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['access_token'] as String?,
      json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      json['refresh_token'] as String?,
    )
      ..status = json['status'] as int?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'user': instance.user,
    };

CarResponse _$CarResponseFromJson(Map<String, dynamic> json) => CarResponse(
      json['_id'] as String?,
      json['code'] as String?,
      json['carType'] as String?,
      json['password'] as String?,
      json['isActive'] as bool?,
      json['admin'] == null
          ? null
          : UserResponse.fromJson(json['admin'] as Map<String, dynamic>),
      (json['users'] as List<dynamic>?)
          ?.map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['firmware'] as Map<String, dynamic>?,
      json['currentSpeed'] as int?,
      json['defaultSpeed'] as int?,
      json['carLocation'] as Map<String, dynamic>?,
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$CarResponseToJson(CarResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'carType': instance.carType,
      'password': instance.password,
      'isActive': instance.isActive,
      'admin': instance.admin,
      'users': instance.users,
      'defaultSpeed': instance.defaultSpeed,
      'currentSpeed': instance.currentSpeed,
      'carLocation': instance.carLocation,
      'firmware': instance.firmware,
      'createdAt': instance.createdAt,
    };

MyCarsResponse _$MyCarsResponseFromJson(Map<String, dynamic> json) =>
    MyCarsResponse(
      (json['my_cars'] as List<dynamic>?)
          ?.map((e) => CarResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$MyCarsResponseToJson(MyCarsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'my_cars': instance.myCars,
    };

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'user': instance.user,
    };
