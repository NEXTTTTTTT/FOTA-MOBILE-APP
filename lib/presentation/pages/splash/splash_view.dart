import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fota_mobile_app/app/constants.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/user_cubit/user_cubit.dart';
import '../../../app/app_prefs.dart';
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

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) async {
      if (isUserLoggedIn) {
        await _appPreferences.getUserId().then((value) {
          Constants.myId = value;
          BlocProvider.of<UserCubit>(context).getMyData();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
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

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
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
