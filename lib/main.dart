import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fota_mobile_app/app/constants.dart';
import 'app/di.dart' as di;

import 'app/app.dart';
import 'bloc_observer.dart';

void main() async {
  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();
  // firebase initalize
  await Firebase.initializeApp();
  // dependency injection
  await di.initAppModule();

  //* get device token
  Constants.fcmToken = await FirebaseMessaging.instance.getToken();
  print(Constants.fcmToken);

  // bloc observer
  BlocOverrides.runZoned(
      () =>
          // run app
          runApp(const MyApp()),
      blocObserver: MyBlocObserver());
}
