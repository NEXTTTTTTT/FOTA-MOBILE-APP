import 'dart:async';

import '../../../domain/usecase/register_usecase.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../base_view_model/base_view_model.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _fullnameStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController<CredentialsObject>
      registerSuccessfullyStreamController =
      StreamController<CredentialsObject>();

  var registerObject =
      RegisterObject(email: "", fullName: "", password: "", userName: "");

  final RegisterUseCase _registerUseCase;
  RegisterViewModel(
    this._registerUseCase,
  );

  @override
  void dispose() {
    _fullnameStreamController.close();
    _emailStreamController.close();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    registerSuccessfullyStreamController.close();
  }

  // inputs

  @override
  void start() {
    // view tell state renderer to show the content
    inputState.add(ContentState());
  }

  @override
  void register() async {
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.POPUP_LOADING_STATE,
    ));
    (await _registerUseCase.execute(RegisterUserCaseInput(
            registerObject.fullName,
            registerObject.userName,
            registerObject.email,
            registerObject.password)))
        .fold((failure) {
      // left -> failure
      inputState.add(
          ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
    }, (data) async {
      // right -> data
      inputState.add(ContentState());
      registerSuccessfullyStreamController.add(CredentialsObject(
          accesToken: data.accessToken!,
          refreshToken: data.refreshToken!,
          id: data.user!.id));
    });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputFullName => _fullnameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    registerObject = registerObject.copyWith(email: email);
    _validate();
  }

  @override
  void setFullname(String fullname) {
    inputFullName.add(fullname);
    registerObject = registerObject.copyWith(fullName: fullname);
    _validate();
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    registerObject = registerObject.copyWith(password: password);
    _validate();
  }

  @override
  void setUserName(String userName) {
    inputUserName.add(userName);
    registerObject = registerObject.copyWith(userName: userName);
    _validate();
  }

  // outputs
  @override
  Stream<bool> get outputEmailIsValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputFullNameIsValid => _fullnameStreamController.stream
      .map((fullName) => _isFullNameValid(fullName));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsVaild());

  @override
  Stream<bool> get outputPasswordIsValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputUserNameIsValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  // private function
  bool _isAllInputsVaild() {
    return registerObject.email.isNotEmpty &&
        registerObject.fullName.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.userName.isNotEmpty;
  }

  _isEmailValid(email) {
    return email.isNotEmpty;
  }

  _isFullNameValid(fullName) {
    return fullName.isNotEmpty;
  }

  _isPasswordValid(password) {
    return password.isNotEmpty;
  }

  _isUserNameValid(userName) {
    return userName.isNotEmpty;
  }

  void _validate() {
    _isAllInputsValidStreamController.add(null);
  }
}

abstract class RegisterViewModelInputs {
  void setFullname(String fullname);
  void setEmail(String email);
  void setUserName(String userName);
  void setPassword(String password);
  void register();

  Sink get inputFullName;
  Sink get inputEmail;
  Sink get inputUserName;
  Sink get inputPassword;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputFullNameIsValid;
  Stream<bool> get outputEmailIsValid;
  Stream<bool> get outputUserNameIsValid;
  Stream<bool> get outputPasswordIsValid;
  Stream<bool> get outputIsAllInputsValid;
}
