import 'app_prefs.dart';
import 'di.dart';

import '../domain/model/model.dart';

class Constants {
  AppPreferences _appPreferences = instance();

  static const String baseUrl = "http://fota2022.herokuapp.com/api/v1";
  static late Car defaultCar;
  static late String myId;
}
