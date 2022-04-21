import 'package:flutter/material.dart';

import '../resources/color_manager.dart';


class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: const Center(child: Text('login')),
    );
  }
}
