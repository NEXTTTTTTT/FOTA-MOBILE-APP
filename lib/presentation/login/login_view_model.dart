import 'dart:async';

import 'package:fota_mobile_app/domain/usecase/login_usecase.dart';
import 'package:fota_mobile_app/presentation/base/base_view_model.dart';
import 'package:fota_mobile_app/presentation/common/freezed_data_classes.dart';
import 'package:fota_mobile_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:fota_mobile_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:fota_mobile_app/presentation/resources/strings_manager.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject(userName: "", password: "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  /// inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // view tell state renderer to show the content
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.POPUP_LOADING_STATE,
    ));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold((failure) {
      // left -> failure
      inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
    }, (data) {
      //  right -> success (data)
      inputState.add(ContentState());

      // todo: navigate to main screen
    });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  /// outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  /// private functions
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isUserNameValid(loginObject.userName) &&
        _isPasswordValid(loginObject.password);
  }

  void _validate() {
    inputIsAllInputsValid.add(null);
  }
}

abstract class LoginViewModelInputs {
  // 3 methods for actions
  setUserName(String userName);
  setPassword(String password);
  login();
  // 3 sinks for stream
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
