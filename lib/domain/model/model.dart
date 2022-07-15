import 'package:equatable/equatable.dart';

class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class User extends Equatable {
  String id;
  String fullname;
  String username;
  String email;
  String profileImage;
  String deviceToken;
  bool isActive;
  Map currentLocation;
  String createdAt;
  User(
      {required this.id,
      required this.fullname,
      required this.username,
      required this.email,
      required this.profileImage,
      required this.isActive,
      required this.deviceToken,
      required this.currentLocation,
      required this.createdAt});

  @override
  List<Object> get props => [id, username, createdAt];
}

class Authentication {
  String? accessToken;
  String? refreshToken;
  User? user;
  Authentication(this.accessToken, this.refreshToken, this.user);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}

class Car extends Equatable {
  String id;
  String code;
  String carType;
  String password;
  bool isActive;
  bool isLocked;
  bool isAcOn;
  bool isBagOn;
  int temperature;
  User? admin;
  List<User>? users;
  int defaultSpeed;
  int currentSpeed;
  Map carLocation;
  String firmware;
  String createdAt;

  // will be added after fetching data from APIs
  double? distanceBetween;
  String? placemark;
  Car(
      {required this.id,
      required this.code,
      required this.carType,
      required this.password,
      required this.isActive,
      required this.isAcOn,
      required this.isBagOn,
      required this.isLocked,
      required this.temperature,
      required this.admin,
      required this.users,
      required this.firmware,
      required this.currentSpeed,
      required this.defaultSpeed,
      required this.carLocation,
      required this.createdAt});

  @override
  List<Object?> get props => [users, id, code, admin];
}

class Success {
  final String msg;

  Success(this.msg);
}

class Notify {
  final String id;
  final User? user;
  final String text;
  final bool isRead;
  final Car? car;

  Notify(this.id, this.user, this.text, this.isRead, this.car);
}
