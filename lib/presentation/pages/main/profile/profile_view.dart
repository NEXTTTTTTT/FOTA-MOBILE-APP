import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fota_mobile_app/presentation/common/state_renderer/state_renderer.dart';

import 'dart:math' as math;

import '../../../../app/functions.dart';

import '../../../../domain/model/model.dart';
import '../../../bussiness_logic/car_cubit/car_cubit.dart';

import '../../../bussiness_logic/position_cubit/position_cubit.dart';
import '../../../bussiness_logic/user_cubit/user_cubit.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/style_manager.dart';

import '../../../resources/values_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserDataLoadedState) {
        return _getContentWidget(context, state.userData);
      } else if (state is UserDataLoadingState) {
        return StateRenderer(
            stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,
            retryActionFunction: () {});
      } else {
        return StateRenderer(
          stateRendererType: StateRendererType.EMPTY_SCREEN_STATE,
          retryActionFunction: () {},
          message: "No data yet",
        );
      }
    });
  }

  Widget _getContentWidget(context, User user) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s12,
        ),

        getUserRow(user),
        const SizedBox(
          height: AppSize.s12,
        ),

        
        getCarsNumberWidget(context),
        
        // email
        getEmailWidget(context, user),
        // currnet location
        const PlaceMarkWidget(),
        const SizedBox(
          height: AppSize.s12,
        ),
        // getGreyLine(),
      ],
    );
  }

  getUserRow(user) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        children: [
          CircleAvatar(
              child: Text(
                getChars(user.fullname),
                style: getRegularStyle(
                    color: ColorManager.white, fontSize: FontSizeManager.s70),
              ),
              backgroundColor:
                  Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
              radius: AppSize.s80),
          const SizedBox(
            height: AppSize.s20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user.fullname,
                style: getBoldStyle(
                    color: ColorManager.darkGrey,
                    fontSize: FontSizeManager.s30),
              ),
              Text(
                user.username,
                style: getRegularStyle(
                    color: ColorManager.grey, fontSize: FontSizeManager.s18),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getGreyLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p15),
      child: Container(
        height: AppSize.s1,
        width: double.infinity,
        color: ColorManager.grey1.withOpacity(0.3),
      ),
    );
  }

  getCarsNumberWidget(context) {
    var carCubit = BlocProvider.of<CarCubit>(context);
    return BlocBuilder<CarCubit, CarState>(
      builder: (context, state) {
        if (carCubit.myCarsData.isNotEmpty) {
          return Column(
            children: [
              getGreyLine(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        carCubit.myCarsData
                            .where((car) => isIamAdminOfTheCar(car))
                            .length
                            .toString(),
                        style: getBoldStyle(
                            color: ColorManager.darkGrey,
                            fontSize: FontSizeManager.s30),
                      ),
                      Text(
                        'Owned cars',
                        style: getRegularStyle(
                            color: ColorManager.grey,
                            fontSize: FontSizeManager.s14),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        carCubit.myCarsData
                            .where((car) => !isIamAdminOfTheCar(car))
                            .length
                            .toString(),
                        style: getBoldStyle(
                            color: ColorManager.darkGrey,
                            fontSize: FontSizeManager.s30),
                      ),
                      Text(
                        'Shared cars',
                        style: getRegularStyle(
                            color: ColorManager.grey,
                            fontSize: FontSizeManager.s14),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        carCubit.myCarsData
                            .where((car) => !car.isMotorOn)
                            .length
                            .toString(),
                        style: getBoldStyle(
                            color: ColorManager.darkGrey,
                            fontSize: FontSizeManager.s30),
                      ),
                      Text(
                        'Available cars',
                        style: getRegularStyle(
                            color: ColorManager.grey,
                            fontSize: FontSizeManager.s14),
                      ),
                    ],
                  ),
                ],
              ),
            getGreyLine(),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  getEmailWidget(context, User user) {
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
                user.email,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlaceMarkWidget extends StatelessWidget {
  const PlaceMarkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _bloc = BlocProvider.of<PositionCubit>(context);
    return BlocBuilder<PositionCubit, PositionState>(builder: (context, state) {
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
    });
  }
}
