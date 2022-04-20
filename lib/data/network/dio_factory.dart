import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fota_mobile_app/app/app_prefs.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/dio.dart';

import '../../app/constants.dart';

const String APPLICATION_JSON ="application/json";
const String CONTENT_TYPE ="content-type";
const String ACCEPT ="accept";
const String AUTHORIZATION ="authorization";
const String DEFAULT_LANGUAGE ="language";


class DioFactory{
  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio()async{
    Dio dio=Dio();
    int _timeout = 60*1000; // 1 minute
    String language = await _appPreferences.getAppLanguage();
    Map<String,String>headers={
      CONTENT_TYPE : APPLICATION_JSON,
      ACCEPT : APPLICATION_JSON,
      AUTHORIZATION : Constants.token,
      DEFAULT_LANGUAGE : language
    };

    dio.options = BaseOptions(
     baseUrl: Constants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      headers: headers,
    );

    if(kReleaseMode){
      print('release mode, no logs');
    }
    else{
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}