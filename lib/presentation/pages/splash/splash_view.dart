import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app/app_prefs.dart';
import 'splash_view_model.dart';
import '../../resources/routes_manager.dart';

import '../../../app/di.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final SplashViewModel _splashViewModel = instance<SplashViewModel>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 1), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) async {
      if (isUserLoggedIn) {
        // refresh token
        _splashViewModel.refreshToken();
      } else {
        _appPreferences
            .isOnBoardingScreenViewed()
            .then((isOnBoardingScreenViewed) => {
                  if (isOnBoardingScreenViewed)
                    {Navigator.pushReplacementNamed(context, Routes.loginRoute)}
                  else
                    {
                      Navigator.pushReplacementNamed(
                          context, Routes.onBoardingRoute)
                    }
                });
      }
    });
  }

  _bind() {
    _splashViewModel.start();
    _splashViewModel.isRefreshSuccess.stream.listen((isSuccess) {
      if (isSuccess) {
        //* navigate to main screen
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        
      } else {
        //* navigate to login screen
        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
    _startDelay();
  }

  @override
  void dispose() {
    _splashViewModel.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: Center(
          child: SvgPicture.asset(AssetsManager.splashLogo),
        ));
  }
}
