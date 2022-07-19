import 'package:flutter/cupertino.dart';


class Constants {
  static const String baseUrl = "http://fota2022.herokuapp.com/api/v1";
  static String? myId;
  static GlobalKey<NavigatorState> navigatorKey= GlobalKey<NavigatorState>();
  static  String? fcmToken ;
}


enum CarInterfaces {gps,speed,motor,lock,ac,temp,bag}
extension CarInterfacesEnum on CarInterfaces {
  String get value{
    switch(this){

      case CarInterfaces.gps:
        return 'gps';
      case CarInterfaces.speed:
        return 'speed';
      case CarInterfaces.motor:
        return 'motor';
      case CarInterfaces.lock:
        return 'lock';
      case CarInterfaces.ac:
        return 'ac';
      case CarInterfaces.temp:
        return 'temp';
      case CarInterfaces.bag:
        return 'bag';
    }
  }
}
