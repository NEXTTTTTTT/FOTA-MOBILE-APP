import 'package:flutter/material.dart';
import 'package:fota_mobile_app/presentation/resources/strings_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage
({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppStrings.home),);
  }
}