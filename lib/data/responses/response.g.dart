// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['_id'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      deviceToken: json['deviceToken'] as String?,
      isActive: json['isActive'] as bool?,
      currentLocation: json['currentLocation'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] as String?,
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
      accessToken: json['access_token'] as String?,
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      refreshToken: json['refresh_token'] as String?,
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
      id: json['_id'] as String?,
      code: json['code'] as String?,
      carType: json['carType'] as String?,
      password: json['password'] as String?,
      isActive: json['isActive'] as bool?,
      admin: json['admin'] == null
          ? null
          : UserResponse.fromJson(json['admin'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      firmware: json['firmware'] as String?,
      currentSpeed: json['currentSpeed'] as int?,
      defaultSpeed: json['defaultSpeed'] as int?,
      carLocation: json['carLocation'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] as String?,
    )
      ..isLocked = json['isLocked'] as bool?
      ..isACOn = json['isACOn'] as bool?
      ..temperature = json['temperature'] as int?
      ..isBagOn = json['isBagOn'] as bool?;

Map<String, dynamic> _$CarResponseToJson(CarResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'carType': instance.carType,
      'password': instance.password,
      'isActive': instance.isActive,
      'isLocked': instance.isLocked,
      'isACOn': instance.isACOn,
      'temperature': instance.temperature,
      'isBagOn': instance.isBagOn,
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
      myCars: (json['my_cars'] as List<dynamic>?)
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
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'user': instance.user,
    };

UserDataListResponse _$UserDataListResponseFromJson(
        Map<String, dynamic> json) =>
    UserDataListResponse(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$UserDataListResponseToJson(
        UserDataListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'users': instance.users,
    };
