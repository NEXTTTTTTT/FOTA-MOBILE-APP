import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../domain/usecase/register_usecase.dart';
import '../common/freezed_data_classes.dart';
import 'register_view_model.dart';
import '../resources/routes_manager.dart';

import '../common/state_renderer/state_renderer_impl.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _fullnameContoller = TextEditingController();
  final TextEditingController _usernameContoller = TextEditingController();
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _registerViewModel.start();

    _fullnameContoller.addListener(() {
      _registerViewModel.setFullname(_fullnameContoller.text);
    });
    _usernameContoller.addListener(() {
      _registerViewModel.setUserName(_usernameContoller.text);
    });
    _emailContoller.addListener(() {
      _registerViewModel.setEmail(_emailContoller.text);
    });
    _passwordContoller.addListener(() {
      _registerViewModel.setPassword(_passwordContoller.text);
    });

    _registerViewModel.registerSuccessfullyStreamController.stream
        .listen((credentials) {
      //* save credentials
      _appPreferences.setToken(credentials.accesToken);
      _appPreferences.setRefreshToken(credentials.refreshToken);
      _appPreferences.setUserId(credentials.id);

      //* reset dependency injection
      resetAllModules();
      
      //* navigate to main screen
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _registerViewModel.outputState,
          builder: ((context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () => _registerViewModel.register()) ??
                _getContentWidget();
          })),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SvgPicture.asset(AssetsManager.splashLogo),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: StreamBuilder<bool>(
                stream: _registerViewModel.outputFullNameIsValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _fullnameContoller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: AppStrings.fullname,
                      labelText: AppStrings.fullname,
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.fullnameError,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: StreamBuilder<bool>(
                stream: _registerViewModel.outputUserNameIsValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _usernameContoller,
                    keyboardType: TextInputType.name,
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

            //* Email Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: StreamBuilder<bool>(
                stream: _registerViewModel.outputEmailIsValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _emailContoller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: AppStrings.email,
                      labelText: AppStrings.email,
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.emailError,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: StreamBuilder<bool>(
                stream: _registerViewModel.outputPasswordIsValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _passwordContoller,
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
                      Navigator.pushNamed(context, Routes.loginRoute);
                    },
                    child: const Text(AppStrings.loginText),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: StreamBuilder<bool>(
                  stream: _registerViewModel.outputIsAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: (snapshot.data ?? false)
                                ? MaterialStateProperty.all(
                                    ColorManager.primary)
                                : MaterialStateProperty.all(
                                    ColorManager.lightGrey),
                          ),
                          onPressed: () {
                            if (snapshot.data ?? false) {
                              _registerViewModel.register();
                            }
                          },
                          child: Text(
                            AppStrings.register,
                            style: Theme.of(context).textTheme.headline2,
                          )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
