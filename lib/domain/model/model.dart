class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class User{
  String id;
  String fullname;
  String username;
  String email;
  String profileImage;
  String deviceToken;
  bool isActive;
  Map currentLocation;

  String createdAt;
  User(this.id,this.fullname,this.username,this.email,this.profileImage,this.isActive,this.deviceToken,this.currentLocation,this.createdAt);
}



class Authentication{
  String? accessToken;
  User? user;
  Authentication(this.accessToken,this.user);
}

class DeviceInfo{
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name,this.identifier,this.version);
}