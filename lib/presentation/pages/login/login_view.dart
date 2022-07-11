import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fota_mobile_app/app/app_prefs.dart';
import 'package:fota_mobile_app/presentation/pages/login/login_view_model.dart';

import '../../../app/di.dart';
import '../../../app/functions.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _loginViewModel.start();
    _userNameController.addListener(
        () => _loginViewModel.setUserName(_userNameController.text));
    _passwordController.addListener(
        () => _loginViewModel.setPassword(_passwordController.text));

    _loginViewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((credentials) {
      //* save credentials
      _appPreferences.setToken(credentials.accesToken);
      _appPreferences.setRefreshToken(credentials.refreshToken);
      _appPreferences.setUserId(credentials.id);

      //* set my id as const
      setMyIdAsConst(id:credentials.id);

      //* reset dependency injection to update
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
    _loginViewModel.dispose();
    super.dispose();
  }

// commit
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _loginViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                    context, _getContent(), () => _loginViewModel.login()) ??
                _getContent();
          }),
    );
  }

  Widget _getContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SvgPicture.asset(AssetsManager.splashLogo),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
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
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
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
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: StreamBuilder<bool>(
                  stream: _loginViewModel.outputIsAllInputsValid,
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
                              _loginViewModel.login();
                            }
                          },
                          child: Text(
                            AppStrings.login,
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
