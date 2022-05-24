import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppStrings.notifications),);
  }
}