import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fota_mobile_app/presentation/resources/font_manager.dart';
import 'package:fota_mobile_app/presentation/resources/routes_manager.dart';
import 'package:fota_mobile_app/presentation/resources/style_manager.dart';
import 'package:fota_mobile_app/presentation/resources/values_manager.dart';
import '../../app/constants.dart';
import 'home/home_veiw.dart';
import 'notification/notification.dart';
import 'profile/profile_view.dart';
import 'setting/setting.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';

class AddCarButtonWidget extends StatelessWidget {
  const AddCarButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: InkWell(
        onTap: () {
          //* Navigate to add car screen
          Navigator.of(context).pushNamed(Routes.addCar);
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: AppSize.s1_5,
                color: ColorManager.grey,
              )),
          child: Icon(
            Icons.add,
            size: AppSize.s30,
            color: ColorManager.grey,
          ),
        ),
      ),
    );
  }
}

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

  List<String> titles = [
    AppStrings.myCars,
    AppStrings.notifications,
    AppStrings.settings,
    AppStrings.profile
  ];

  int _currentIndex = 0;
  String _title = AppStrings.myCars;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: ColorManager.white,
          elevation: 0,
          title: Text(
            _title,
            style: getRegularStyle(
                color: ColorManager.grey, fontSize: FontSizeManager.s24),
          ),
          actions: _currentIndex == 0 ? [const AddCarButtonWidget()] : null,
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: Container(
          color: ColorManager.white,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: AppStrings.home),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.app_badge),
                  label: AppStrings.notifications),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: AppStrings.settings),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: AppStrings.profile),
            ],
            selectedItemColor: ColorManager.black,
            unselectedItemColor: ColorManager.grey,
            onTap: _onTap,
          ),
        ));
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
