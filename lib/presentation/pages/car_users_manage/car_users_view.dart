import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/car_cubit/car_cubit.dart';
import 'package:fota_mobile_app/presentation/resources/routes_manager.dart';

import '../../../app/functions.dart';
import '../../../domain/model/model.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';
import 'dart:math' as math;

class AddUserButtonWidget extends StatelessWidget {
  const AddUserButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: InkWell(
        onTap: () {
          //* Navigate to add car screen
          Navigator.of(context).pushNamed(Routes.searchUsers);
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

class CarUsersView extends StatelessWidget {
  const CarUsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.arrow_left),
          color: ColorManager.grey,
        ),
        centerTitle: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: ColorManager.white,
        elevation: 0,
        actions: [const AddUserButtonWidget()],
        title: Text(
          'Users',
          style: getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSizeManager.s20),
        ),
      ),
      body: BlocBuilder<CarCubit, CarState>(builder: (context, state) {
        Car myCar = BlocProvider.of<CarCubit>(context).myCarsData.singleWhere(
            (element) =>
                element.code ==
                BlocProvider.of<CarCubit>(context).selectedCarCode);

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p5),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myCar.users!.length,
                  itemBuilder: (context, index) => getUserItem(
                    myCar.users![index],
                    context,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: AppSize.s5,
                      mainAxisSpacing: AppSize.s5),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget getUserItem(
    User user,
    context,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppMargin.m16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                            child: Text(
                              getChars(user.fullname),
                              style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSizeManager.s20),
                            ),
                            backgroundColor: Color(
                                    (math.Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                .withOpacity(1.0),
                            radius: AppSize.s40),
                      ),
                      CircleAvatar(
                        backgroundColor: ColorManager.white,
                        radius: 15,
                        child: InkWell(
                          onTap: () {
                            //  remove user away my car
                            BlocProvider.of<CarCubit>(context)
                                .removeUserAwayMyCar(
                                    user.id,
                                    BlocProvider.of<CarCubit>(context)
                                        .selectedCarCode!);

                            //show toast
                            showShortToast(
                                '${user.fullname.toLowerCase()} removed successfully!');
                          },
                          child:  CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.red,
                            child: Icon(
                              CupertinoIcons.xmark,color: ColorManager.white,size:AppSize.s14
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Text(
                    user.fullname,
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                        color: ColorManager.darkGrey,
                        fontSize: FontSizeManager.s16),
                  ),
                  Text(
                    user.username,
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                        color: ColorManager.grey,
                        fontSize: FontSizeManager.s14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
