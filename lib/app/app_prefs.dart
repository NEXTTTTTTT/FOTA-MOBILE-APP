import 'package:fota_mobile_app/app/extentions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manager.dart';

const String PREF_KEY_LANGUAGE = "PREF_KEY_LANGUAGE";
const String PREF_KEY_ONBOARDING = "PREF_KEY_ONBOARDING";
const String PREF_KEY_LOGIN = "PREF_KEY_LOGIN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREF_KEY_LANGUAGE);
    if(language !=null && language.isNotEmpty)
      {
        return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREF_KEY_ONBOARDING, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
   return  _sharedPreferences.getBool(PREF_KEY_ONBOARDING)??FALSE;
  }

   Future<void> setUserLoggIn() async {
    _sharedPreferences.setBool(PREF_KEY_LOGIN, true);
  }

  Future<bool> isUserLoggedIn() async {
   return  _sharedPreferences.getBool(PREF_KEY_LOGIN)??FALSE;
  }

}
