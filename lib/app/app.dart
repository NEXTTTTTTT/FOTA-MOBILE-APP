import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fota_mobile_app/app/di.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/app_cubit/app_cubit.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/map_cubit/map_cubit.dart';

import '../presentation/bussiness_logic/car_cubit/car_cubit.dart';
import '../presentation/bussiness_logic/position_cubit/position_cubit.dart';
import '../presentation/bussiness_logic/user_cubit/user_cubit.dart';
import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => instance<MapCubit>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) =>
              instance<PositionCubit>()..getPostition(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) =>
              instance<CarCubit>(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) =>
              instance<UserCubit>(),
          lazy: false,
        ),
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: MaterialApp(
        navigatorKey: Constants.navigatorKey,
        theme: getApplicationTheme(),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
