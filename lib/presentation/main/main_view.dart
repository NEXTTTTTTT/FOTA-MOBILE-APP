import 'package:flutter/material.dart';
import 'package:fota_mobile_app/presentation/main/home.dart';
import 'package:fota_mobile_app/presentation/main/notification.dart';
import 'package:fota_mobile_app/presentation/main/profile.dart';
import 'package:fota_mobile_app/presentation/main/setting.dart';
import 'package:fota_mobile_app/presentation/resources/color_manager.dart';
import 'package:fota_mobile_app/presentation/resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    NotificationPage(),
    SettingPage(),
    ProfilePage(),
  ];

  List<String> titles =[
    AppStrings.home,
    AppStrings.notifications,
    AppStrings.settings,
    AppStrings.profile
  ];

  int _currentIndex = 0;
  String _title = AppStrings.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          titles[_currentIndex],
          style: Theme.of(context).textTheme.headline2,
        )),
        body: pages[_currentIndex],
        bottomNavigationBar: Container(
          color: ColorManager.white,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            items:  const[
              BottomNavigationBarItem(icon: Icon(Icons.home),label: AppStrings.home),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_none),label: AppStrings.notifications),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: AppStrings.settings),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: AppStrings.profile),
            ],
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.grey,
            onTap: onTap,
          ),
        ));
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
