import 'dart:async';

import 'package:fota_mobile_app/app/app_prefs.dart';
import 'package:fota_mobile_app/app/di.dart' as di;

import 'package:fota_mobile_app/domain/usecase/refresh_token_usecase.dart';
import 'package:fota_mobile_app/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../app/constants.dart';
import '../../data/network/error_handler.dart';

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

  _setMyIdAsConst() async {
    /// set id in constants
    var myId = await _appPreferences.getUserId();
    Constants.myId = myId;
  }

  void refreshToken() async {
    var refreshToken = await _appPreferences.getRefreshToken();
    (await _refreshTokenUseCase.execute(refreshToken)).fold((failure) async {
      // return failure => logout (navigate to login screen)
      if (failure == DataSource.NO_INTERNET_CONNECTION.getFailure()) {
        //* skip refreshing if no internet connection
        isRefreshSuccess.add(true);
        _setMyIdAsConst();
      } else {
        // TODO: make it false and clear sharedpreferances and delete setId
        isRefreshSuccess.add(true);
        _setMyIdAsConst();
      }
    }, (data) async {
      // return Authentication (acces token ) => update access token
      await _appPreferences.setToken(data.accessToken!);
      di.resetAllModules();
      isRefreshSuccess.add(true);
      _setMyIdAsConst();
    });
  }
}

abstract class SplashViewInputs {}

abstract class SplashViewOutputs {}
