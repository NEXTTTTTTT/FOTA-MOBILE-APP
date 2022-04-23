import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject{
  const factory LoginObject({
    required String userName,
    required String password,
}) = _LoginObject;
}