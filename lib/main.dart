import 'package:flutter/material.dart';
import 'package:fota_mobile_app/app/di.dart';

import 'app/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp( MyApp());
}


