import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/map_cubit/map_cubit.dart';

import '../../../../app/functions.dart';

import '../../../bussiness_logic/app_cubit/app_cubit.dart';
import '../../../bussiness_logic/cars_bloc/cars_bloc.dart';
import '../../../bussiness_logic/position_bloc/position_bloc.dart';
import '../../../bussiness_logic/user_bloc/user_bloc.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/style_manager.dart';

import '../../../resources/values_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getContentWidget(context);
  }

  Widget _getContentWidget(context) {
    return Column(
      children: [
        getUserRow(),
        const SizedBox(
          height: AppSize.s12,
        ),
        getCarsNumberWidget(),
        getGreyLine(),
        // email
        getEmailWidget(),
        // currnet location
        const PlaceMarkWidget(),
        logoutWidget(context),
      ],
    );
  }

  getUserRow() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserDataLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Row(
              children: [
                // TODO: change profile pic
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
                      state.userData.fullname,
                      style: getBoldStyle(
                          color: ColorManager.darkGrey,
                          fontSize: FontSizeManager.s20),
                    ),
                    Text(
                      state.userData.username,
                      style: getRegularStyle(
                          color: ColorManager.grey,
                          fontSize: FontSizeManager.s18),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget getGreyLine() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Container(
        height: AppSize.s1,
        width: double.infinity,
        color: ColorManager.grey,
      ),
    );
  }

  getCarsNumberWidget() {
    return BlocBuilder<CarsBloc, CarsState>(
      builder: (context, state) {
        if (state is MyCarsLoadedState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    state.myCars
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
                    state.myCars
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
                    state.myCars.where((car) => car.isActive).length.toString(),
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
          );
        } else {
          return Container();
        }
      },
    );
  }

  getEmailWidget() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserDataLoadedState) {
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
                      AppStrings.email,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      state.userData.email,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

logoutWidget(context) {
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
                    color: ColorManager.primary, fontSize: FontSizeManager.s20),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class PlaceMarkWidget extends StatelessWidget {
  const PlaceMarkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<PositionBloc>(context);
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
                _bloc.myPlacemark ?? '-',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class CustomTile extends StatelessWidget {
//   final String title;
//   final String body;
//   const CustomTile({
//     required this.title,
//     required this.body,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: AppPadding.p20, vertical: AppPadding.p20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.headline3,
//               ),
//               Text(
//                 body,
//                 style: Theme.of(context).textTheme.caption,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
