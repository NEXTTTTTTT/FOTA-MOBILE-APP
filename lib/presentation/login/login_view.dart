import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fota_mobile_app/presentation/login/login_view_model.dart';
import 'package:fota_mobile_app/presentation/resources/color_manager.dart';
import 'package:fota_mobile_app/presentation/resources/strings_manager.dart';
import 'package:fota_mobile_app/presentation/resources/values_manager.dart';

import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _loginViewModel =
      LoginViewModel(null); // todo: pass login use case

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _loginViewModel.start();
    _userNameController.addListener(
        () => _loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(
        () => _loginViewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget _getContent() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SvgPicture.asset(AssetsManager.splashLogo),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _loginViewModel.outputIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppStrings.userName,
                        labelText: AppStrings.userName,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.userNameError,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _loginViewModel.outputIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: AppStrings.password,
                        labelText: AppStrings.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordError,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // text Button
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.forgetPasswordRoute);
                      },
                      child: Text(AppStrings.forgetPassword),
                    ),
                    // text Button
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.registerRoute);
                      },
                      child: Text(AppStrings.registerText),
                    ),


                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50),
                child: StreamBuilder<bool>(
                    stream: _loginViewModel.outputIsAllInputsValid,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: (snapshot.data ?? false)
                                ? MaterialStateProperty.all(ColorManager.primary)
                                : MaterialStateProperty.all(ColorManager.lightGrey),
                          ),
                          onPressed: () {
                            (snapshot.data?? false) ? (){
                              _loginViewModel.login();
                            }: null;
                          },
                          child: Text(AppStrings.login));
                    }),

              ),
            ],
          ),
        ),
      ),
    );
  }
}


