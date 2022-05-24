import 'package:flutter/material.dart';
import 'package:fota_mobile_app/app/constants.dart';

import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';


// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp._internal(); //private named constructor
  int appState =0;
  static final MyApp instance = MyApp._internal(); //single instance --singleton
  factory MyApp() => instance; //factory for the class instance

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      debugShowCheckedModeBanner: false,

    );
  }
}
