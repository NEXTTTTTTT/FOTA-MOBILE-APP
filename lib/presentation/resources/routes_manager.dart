import 'package:flutter/material.dart';
import 'package:fota_mobile_app/presentation/pages/car_users_manage/car_users_view.dart';
import 'package:fota_mobile_app/presentation/pages/car_users_manage/search_users.dart';
import '../../app/di.dart' as di;

import '../pages/add_car/add_car_view.dart';
import '../pages/car_details/car_details_view.dart';
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
  static const String mainRoute = "/main";
  static const String carDetailsRoute = "/carDetails";
  static const String addCar = "/addCar";
  static const String carUsers = "/carUsers";
  static const String searchUsers = "/searchUsers";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());

      case Routes.loginRoute:
        di.initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.registerRoute:
        di.initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());

      

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());

      case Routes.carDetailsRoute:
        return MaterialPageRoute(builder: (_) =>  CarDetailsView());

      case Routes.addCar:
        return MaterialPageRoute(builder: (_) => const AddCarView());
      
      case Routes.carUsers:
        return MaterialPageRoute(builder: (_) => const CarUsersView());
      
      case Routes.searchUsers:
        return MaterialPageRoute(builder: (_) =>  SearchUsersView());

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
