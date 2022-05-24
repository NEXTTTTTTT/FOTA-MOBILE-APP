// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res>;
  $Res call({String userName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res> implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  final LoginObject _value;
  // ignore: unused_field
  final $Res Function(LoginObject) _then;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$LoginObjectCopyWith(
          _LoginObject value, $Res Function(_LoginObject) then) =
      __$LoginObjectCopyWithImpl<$Res>;
  @override
  $Res call({String userName, String password});
}

/// @nodoc
class __$LoginObjectCopyWithImpl<$Res> extends _$LoginObjectCopyWithImpl<$Res>
    implements _$LoginObjectCopyWith<$Res> {
  __$LoginObjectCopyWithImpl(
      _LoginObject _value, $Res Function(_LoginObject) _then)
      : super(_value, (v) => _then(v as _LoginObject));

  @override
  _LoginObject get _value => super._value as _LoginObject;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
  }) {
    return _then(_LoginObject(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  const _$_LoginObject({required this.userName, required this.password});

  @override
  final String userName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginObject &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$LoginObjectCopyWith<_LoginObject> get copyWith =>
      __$LoginObjectCopyWithImpl<_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  const factory _LoginObject(
      {required final String userName,
      required final String password}) = _$_LoginObject;

  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoginObjectCopyWith<_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  String get fullName => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res>;
  $Res call({String fullName, String userName, String email, String password});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  final RegisterObject _value;
  // ignore: unused_field
  final $Res Function(RegisterObject) _then;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? userName = freezed,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$RegisterObjectCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$RegisterObjectCopyWith(
          _RegisterObject value, $Res Function(_RegisterObject) then) =
      __$RegisterObjectCopyWithImpl<$Res>;
  @override
  $Res call({String fullName, String userName, String email, String password});
}

/// @nodoc
class __$RegisterObjectCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res>
    implements _$RegisterObjectCopyWith<$Res> {
  __$RegisterObjectCopyWithImpl(
      _RegisterObject _value, $Res Function(_RegisterObject) _then)
      : super(_value, (v) => _then(v as _RegisterObject));

  @override
  _RegisterObject get _value => super._value as _RegisterObject;

  @override
  $Res call({
    Object? fullName = freezed,
    Object? userName = freezed,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_RegisterObject(
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RegisterObject implements _RegisterObject {
  const _$_RegisterObject(
      {required this.fullName,
      required this.userName,
      required this.email,
      required this.password});

  @override
  final String fullName;
  @override
  final String userName;
  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'RegisterObject(fullName: $fullName, userName: $userName, email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterObject &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$RegisterObjectCopyWith<_RegisterObject> get copyWith =>
      __$RegisterObjectCopyWithImpl<_RegisterObject>(this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  const factory _RegisterObject(
      {required final String fullName,
      required final String userName,
      required final String email,
      required final String password}) = _$_RegisterObject;

  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RegisterObjectCopyWith<_RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CredentialsObject {
  String get accesToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CredentialsObjectCopyWith<CredentialsObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialsObjectCopyWith<$Res> {
  factory $CredentialsObjectCopyWith(
          CredentialsObject value, $Res Function(CredentialsObject) then) =
      _$CredentialsObjectCopyWithImpl<$Res>;
  $Res call({String accesToken, String refreshToken, String id});
}

/// @nodoc
class _$CredentialsObjectCopyWithImpl<$Res>
    implements $CredentialsObjectCopyWith<$Res> {
  _$CredentialsObjectCopyWithImpl(this._value, this._then);

  final CredentialsObject _value;
  // ignore: unused_field
  final $Res Function(CredentialsObject) _then;

  @override
  $Res call({
    Object? accesToken = freezed,
    Object? refreshToken = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      accesToken: accesToken == freezed
          ? _value.accesToken
          : accesToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CredentialsObjectCopyWith<$Res>
    implements $CredentialsObjectCopyWith<$Res> {
  factory _$CredentialsObjectCopyWith(
          _CredentialsObject value, $Res Function(_CredentialsObject) then) =
      __$CredentialsObjectCopyWithImpl<$Res>;
  @override
  $Res call({String accesToken, String refreshToken, String id});
}

/// @nodoc
class __$CredentialsObjectCopyWithImpl<$Res>
    extends _$CredentialsObjectCopyWithImpl<$Res>
    implements _$CredentialsObjectCopyWith<$Res> {
  __$CredentialsObjectCopyWithImpl(
      _CredentialsObject _value, $Res Function(_CredentialsObject) _then)
      : super(_value, (v) => _then(v as _CredentialsObject));

  @override
  _CredentialsObject get _value => super._value as _CredentialsObject;

  @override
  $Res call({
    Object? accesToken = freezed,
    Object? refreshToken = freezed,
    Object? id = freezed,
  }) {
    return _then(_CredentialsObject(
      accesToken: accesToken == freezed
          ? _value.accesToken
          : accesToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CredentialsObject implements _CredentialsObject {
  const _$_CredentialsObject(
      {required this.accesToken, required this.refreshToken, required this.id});

  @override
  final String accesToken;
  @override
  final String refreshToken;
  @override
  final String id;

  @override
  String toString() {
    return 'CredentialsObject(accesToken: $accesToken, refreshToken: $refreshToken, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CredentialsObject &&
            const DeepCollectionEquality()
                .equals(other.accesToken, accesToken) &&
            const DeepCollectionEquality()
                .equals(other.refreshToken, refreshToken) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(accesToken),
      const DeepCollectionEquality().hash(refreshToken),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$CredentialsObjectCopyWith<_CredentialsObject> get copyWith =>
      __$CredentialsObjectCopyWithImpl<_CredentialsObject>(this, _$identity);
}

abstract class _CredentialsObject implements CredentialsObject {
  const factory _CredentialsObject(
      {required final String accesToken,
      required final String refreshToken,
      required final String id}) = _$_CredentialsObject;

  @override
  String get accesToken => throw _privateConstructorUsedError;
  @override
  String get refreshToken => throw _privateConstructorUsedError;
  @override
  String get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CredentialsObjectCopyWith<_CredentialsObject> get copyWith =>
      throw _privateConstructorUsedError;
}
