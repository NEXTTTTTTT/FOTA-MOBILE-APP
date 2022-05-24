import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject{
  const factory LoginObject({
    required String userName,
    required String password,
}) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject{
  const factory RegisterObject({
    required String fullName,
    required String userName,
    required String email,
    required String password,
}) = _RegisterObject;
}

@freezed
class CredentialsObject with _$CredentialsObject{
  const factory CredentialsObject({
    required String accesToken,
    required String refreshToken,
    required String id,
}) = _CredentialsObject;
}

