import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/car_cubit/car_cubit.dart';
import 'package:fota_mobile_app/presentation/resources/assets_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';

class AddCarView extends StatefulWidget {
  const AddCarView({Key? key}) : super(key: key);

  @override
  State<AddCarView> createState() => _AddCarViewState();
}

class _AddCarViewState extends State<AddCarView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _carCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var carCubit = BlocProvider.of<CarCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.arrow_left),
          color: ColorManager.grey,
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: ColorManager.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Connect New Car',
              style: getRegularStyle(
                  color: ColorManager.grey, fontSize: FontSizeManager.s22),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  carCubit.connectCar(_carCodeController.text,
                      _passwordController.text, _carNameController.text);
                }
              },
              child: const Text('Connect')),
          const SizedBox(
            width: AppSize.s10,
          )
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Image.asset(AssetsManager.carImage),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppMargin.m16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _carCodeController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: AppStrings.carCode,
                              ),
                            ),
                            const SizedBox(
                              height: AppSize.s14,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                hintText: AppStrings.carPassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Center(child: Text('---- Optional ----')),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppMargin.m16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _carNameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                hintText: AppStrings.putNameToYourCar,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
