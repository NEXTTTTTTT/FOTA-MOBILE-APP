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
    )
      ..status = json['status'] as int?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'access_token': instance.accessToken,
      'user': instance.user,
    };
