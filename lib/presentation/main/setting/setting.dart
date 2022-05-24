import 'package:flutter/material.dart';
import '../../resources/strings_manager.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppStrings.settings),  );
  }
}