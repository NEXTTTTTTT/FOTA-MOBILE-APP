
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manager.dart';

const String PREF_KEY_LANGUAGE = "PREF_KEY_LANGUAGE";
class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage()async{
    String? language = _sharedPreferences.getString(PREF_KEY_LANGUAGE);
    if(language !=null && language.isNotEmpty)
      {
        return language;
      }
    else{
      return LanguageType.ENGLISH.getValue();
    }
  }
}
