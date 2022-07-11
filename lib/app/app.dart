import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fota_mobile_app/app/di.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/app_cubit/app_cubit.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/map_cubit/map_cubit.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/position_bloc/position_bloc.dart';
import 'package:get_it/get_it.dart';

import '../presentation/bussiness_logic/cars_bloc/cars_bloc.dart';
import '../presentation/bussiness_logic/user_bloc/user_bloc.dart';
import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<MapCubit>()),
        BlocProvider(
            create: (context) =>
                instance<PositionBloc>()..add(GetMyPositionEvent())),
        BlocProvider(
          create: (context) => instance<CarsBloc>()..add(const GetMyCarsEvent()),
        ),
        BlocProvider(
            create: (context) =>
                instance<UserBloc>()..add(const GetMyDataEvent())),
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
