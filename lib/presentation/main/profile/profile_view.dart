import 'package:flutter/material.dart';
import 'package:fota_mobile_app/presentation/main/profile/profile_view_model.dart';
import 'package:fota_mobile_app/presentation/resources/color_manager.dart';
import 'package:fota_mobile_app/presentation/resources/font_manager.dart';
import 'package:fota_mobile_app/presentation/resources/style_manager.dart';
import 'package:geolocator/geolocator.dart';
import '../../../app/di.dart';
import '../../../app/functions.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

import '../../../domain/model/model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileViewModel _profileViewModel = instance<ProfileViewModel>();

  _bind() {
    _profileViewModel.start();
    _profileViewModel.getUserData();
    _profileViewModel.getMyCars();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _profileViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _profileViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _profileViewModel.start();
              }) ??
              Container();
        });
  }

  Widget _getContentWidget() {
    return StreamBuilder<User>(
        stream: _profileViewModel.outputUserData,
        builder: ((context, snapshot) {
          return snapshot.data != null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: Row(
                        children: [
                          // TODO: changet profile pic
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/564x/1b/e1/3f/1be13feb311ab005aca97ddf6e34df4a.jpg'),
                            radius: AppSize.s40,
                          ),
                          const SizedBox(
                            width: AppSize.s14,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.fullname,
                                style: getBoldStyle(
                                    color: ColorManager.darkGrey,
                                    fontSize: FontSizeManager.s20),
                              ),
                              Text(
                                snapshot.data!.username,
                                style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSizeManager.s18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    _getCarsNumberWidget(),
                    _getGreyLine(),
                    // email
                    CustomTile(
                        title: AppStrings.email, body: snapshot.data!.email),
                    // currnet location
                    const PlaceMarkWidget(),
                    _logoutWidget(),
                  ],
                )
              : Container();
        }));
  }

  Padding _getGreyLine() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Container(
        height: AppSize.s1,
        width: double.infinity,
        color: ColorManager.grey,
      ),
    );
  }

  _getCarsNumberWidget() {
    return StreamBuilder<List<Car>>(
        stream: _profileViewModel.outputMyCarsList,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          snapshot.data!
                              .where((car) => isIamAdminOfTheCar(car))
                              .length
                              .toString(),
                          style: getBoldStyle(
                              color: ColorManager.darkGrey,
                              fontSize: FontSizeManager.s30),
                        ),
                        Text(
                          'Owned Cars',
                          style: getRegularStyle(
                              color: ColorManager.grey,
                              fontSize: FontSizeManager.s14),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          snapshot.data!
                              .where((car) => !isIamAdminOfTheCar(car))
                              .length
                              .toString(),
                          style: getBoldStyle(
                              color: ColorManager.darkGrey,
                              fontSize: FontSizeManager.s30),
                        ),
                        Text(
                          'Shared Cars',
                          style: getRegularStyle(
                              color: ColorManager.grey,
                              fontSize: FontSizeManager.s14),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          snapshot.data!
                              .where((car) => car.isActive)
                              .length
                              .toString(),
                          style: getBoldStyle(
                              color: ColorManager.darkGrey,
                              fontSize: FontSizeManager.s30),
                        ),
                        Text(
                          'Active Cars',
                          style: getRegularStyle(
                              color: ColorManager.grey,
                              fontSize: FontSizeManager.s14),
                        ),
                      ],
                    ),
                  ],
                )
              : Container();
        });
  }

  _logoutWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p20),
        child: InkWell(
          onTap: (() {
            // logout
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s14),
              border: Border.all(color: ColorManager.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Center(
                child: Text(
                  AppStrings.logout,
                  style: getRegularStyle(
                      color: ColorManager.primary,
                      fontSize: FontSizeManager.s20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceMarkWidget extends StatefulWidget {
  const PlaceMarkWidget({Key? key}) : super(key: key);

  @override
  State<PlaceMarkWidget> createState() => _PlaceMarkWidgetState();
}

class _PlaceMarkWidgetState extends State<PlaceMarkWidget> {
  String? _locationName;
  @override
  void initState() {
    _getUserPlaceMark();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getUserPlaceMark() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
     Placemark placeMark = placemarks[0];
      _locationName = placeMark.country +
          ', ' +
          placeMark.administrativeArea +
          ', ' +
          placeMark.subAdministrativeArea +
          ', ' +
          placeMark.locality;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.currentLocation,
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                _locationName?? '-',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String body;
  const CustomTile({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                body,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
