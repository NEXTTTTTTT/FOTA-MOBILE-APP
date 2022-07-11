import 'package:flutter/cupertino.dart';

import '../domain/model/model.dart';

class Constants {
  static const String baseUrl = "http://fota2022.herokuapp.com/api/v1";
  static Car? defaultCar;
  static String? myId;
  static GlobalKey<NavigatorState> navigatorKey= GlobalKey<NavigatorState>();
}
