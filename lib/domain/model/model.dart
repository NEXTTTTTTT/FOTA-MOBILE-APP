class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class User {
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
}

class Authentication {
  String? accessToken;
  String? refreshToken;
  User? user;
  Authentication(this.accessToken,this.refreshToken, this.user);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}

class Car {
  String id;
  String code;
  String carType;
  String password;
  bool isActive;
  User? admin;
  List<User>? users;
  int defaultSpeed;
  int currentSpeed;
  Map carLocation;
  Map firmware;
  String createdAt;
  Car(
      {required this.id,
      required this.code,
      required this.carType,
      required this.password,
      required this.isActive,
      required this.admin,
      required this.users,
      required this.firmware,
      required this.currentSpeed,
      required this.defaultSpeed,
      required this.carLocation,
      required this.createdAt});
}
