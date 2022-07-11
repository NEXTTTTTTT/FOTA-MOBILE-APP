import 'dart:async';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart' as di;

import '../../../app/functions.dart';
import '../../../domain/usecase/refresh_token_usecase.dart';
import '../../base_view_model/base_view_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../app/constants.dart';
import '../../../data/network/error_handler.dart';

class SplashViewModel extends BaseViewModel
    with SplashViewInputs, SplashViewOutputs {
  final RefreshTokenUseCase _refreshTokenUseCase;
  final StreamController<bool> isRefreshSuccess = BehaviorSubject();
  final AppPreferences _appPreferences;

  SplashViewModel(this._refreshTokenUseCase, this._appPreferences);

  @override
  void start() {}
  @override
  void dispose() {
    isRefreshSuccess.close();
    super.dispose();
  }

  void refreshToken() async {
    var refreshToken = await _appPreferences.getRefreshToken();
    var myId = await _appPreferences.getUserId();
    (await _refreshTokenUseCase.execute(refreshToken)).fold((failure) async {
      // return failure => logout (navigate to login screen)
      if (failure == DataSource.NO_INTERNET_CONNECTION.getFailure()) {
        //* skip refreshing if no internet connection
        isRefreshSuccess.add(true);
        setMyIdAsConst(id: myId);
      } else {
        // TODO: make it false and clear sharedpreferances and delete setId
        isRefreshSuccess.add(false);
        _appPreferences.clearAllMyData();
      }
    }, (data) async {
      // return Authentication (acces token ) => update access token
      await _appPreferences.setToken(data.accessToken!);
      di.resetAllModules();
      isRefreshSuccess.add(true);
      setMyIdAsConst(id:myId);
    });
  }
}

abstract class SplashViewInputs {}

abstract class SplashViewOutputs {}
