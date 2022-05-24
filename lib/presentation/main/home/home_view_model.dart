import 'dart:async';

import 'package:fota_mobile_app/presentation/base/base_view_model.dart';

import '../../../app/app_prefs.dart';
import '../../../app/constants.dart';

import 'package:rxdart/rxdart.dart';

import '../../../domain/model/model.dart';
import '../../../domain/usecase/get_my_cars_usecase.dart';
import '../../../domain/usecase/get_user_data_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/strings_manager.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final GetMyCarsUseCase _getMyCarsUseCase;
  final GetUserDataUseCase _userDataUseCase;
  
  final StreamController _myCarsStreamController = BehaviorSubject<List<Car>>();
  final StreamController _userStreamController = BehaviorSubject<User>();


  final AppPreferences _appPreferences;

  HomeViewModel(
      this._getMyCarsUseCase, this._userDataUseCase, this._appPreferences);
  @override
  void start() {
  }

  @override
  void dispose() {
    _myCarsStreamController.close();
    _userStreamController.close();
    super.dispose();
  }

  getUserData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    var id = await _appPreferences.getUserId();
    (await _userDataUseCase.execute(id)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (data) {
      inputState.add(ContentState());
      inputUserData.add(data);
    });
  }

  getMyCars() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    // TODO: remove app prefs and put id in constants
    var id = await _appPreferences.getUserId();
    (await _getMyCarsUseCase.execute(id)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (data) {
      // if (data.isEmpty){
      //   inputState.add(EmptyState(AppStrings.noCarsYet));
      // } else {
        inputState.add(ContentState());
        inputMyCarsList.add(data);
      // }
    });
  }

  @override
  Sink get inputUserData => _userStreamController.sink;

  @override
  Stream<User> get outputUserData =>
      _userStreamController.stream.map((user) => user);

  @override
  Sink get inputMyCarsList => _myCarsStreamController.sink;

  @override
  Stream<List<Car>> get outputMyCarsList =>
      _myCarsStreamController.stream.map((myCars) => myCars);
}

abstract class HomeViewModelInputs {
  Sink get inputMyCarsList;
  Sink get inputUserData;
}

abstract class HomeViewModelOutputs {
  Stream<List<Car>> get outputMyCarsList;
  Stream<User> get outputUserData;
}
