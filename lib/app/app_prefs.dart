import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manager.dart';
import 'extentions.dart';

const String PREF_KEY_LANGUAGE = "PREF_KEY_LANGUAGE";
const String PREF_KEY_ONBOARDING = "PREF_KEY_ONBOARDING";
const String PREF_KEY_USER_ID = "PREF_KEY_USER_ID";
const String PREF_KEY_TOKEN = "PREF_KEY_TOKEN";
const String PREF_KEY_REFRESH_TOKEN = "PREF_KEY_REFRESH_TOKEN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  //* Language Prefs
  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREF_KEY_LANGUAGE);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setAppLanguage() async {
    // TODO:
  }

  //* User Id Prefs
  Future<String> getUserId() async {
    return _sharedPreferences.getString(PREF_KEY_USER_ID);
  }

  Future<void> setUserId(String id) async {
    _sharedPreferences.setString(PREF_KEY_USER_ID, id);
  }

  Future<void> clearUserId() async {
    _sharedPreferences.remove(PREF_KEY_USER_ID);
  }

  //* Token Prefs
  Future<String> getToken() async {
    return _sharedPreferences.getString(PREF_KEY_TOKEN);
  }

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(PREF_KEY_TOKEN, token);
  }

  Future<void> clearToken() async {
    _sharedPreferences.remove(PREF_KEY_TOKEN);
  }

  //* Check if user logged in
  Future<bool> isUserLoggedIn() async {
    String token = await getToken();
    String id = await getUserId();
    String refreshToken = await getRefreshToken();
    return token != null && token.isNotEmpty && id != null && id.isNotEmpty && refreshToken!=null && refreshToken.isNotEmpty;
  }

  //* On Boarding prefs
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREF_KEY_ONBOARDING, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREF_KEY_ONBOARDING) ?? FALSE;
  }

  //* Refresh Token Prefs
  Future<String> getRefreshToken() async {
    return _sharedPreferences.getString(PREF_KEY_REFRESH_TOKEN);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    _sharedPreferences.setString(PREF_KEY_REFRESH_TOKEN, refreshToken);
  }

  Future<void> clearRefreshToken() async {
    _sharedPreferences.remove(PREF_KEY_REFRESH_TOKEN);
  }
}
