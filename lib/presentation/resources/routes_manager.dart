import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app/constants.dart';
import '../../app/di.dart' as di;

import '../pages/add_car/add_car_view.dart';
import '../pages/car_details/car_details_view.dart';
import '../pages/forget_password/forget_password_view.dart';
import '../pages/login/login_view.dart';
import '../pages/main/main_view.dart';
import '../pages/on_boarding/on_boarding_view.dart';
import '../pages/register/register_view.dart';
import '../pages/splash/splash_view.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String carDetailsRoute = "/carDetails";
  static const String addCar = "/addCar";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        di.initSplashModule();
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());

      case Routes.loginRoute:
        di.initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.registerRoute:
        di.initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());

      case Routes.carDetailsRoute:
        return MaterialPageRoute(builder: (_) =>  CarDetailsView());

      case Routes.addCar:
        return MaterialPageRoute(builder: (_) => const AddCarView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
