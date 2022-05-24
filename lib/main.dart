import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'app/di.dart' as di;

import 'app/app.dart';
import 'bloc_observer.dart';

void main() async{
  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();
  // dependency injection
  await di.initAppModule();
  // bloc observer
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  // run app
  runApp( MyApp());
}


