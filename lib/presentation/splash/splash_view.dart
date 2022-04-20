import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fota_mobile_app/presentation/resources/assets_manager.dart';
import 'package:fota_mobile_app/presentation/resources/color_manager.dart';
import 'package:fota_mobile_app/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;

  _startDelay(){
  _timer = Timer(const Duration(seconds: 3),_goNext);
  }

  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
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
      body: Center(child: SvgPicture.asset(AssetsManager.splashLogo),)
    );
  }
}
