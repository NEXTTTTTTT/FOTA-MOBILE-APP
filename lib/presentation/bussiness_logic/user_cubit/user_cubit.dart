import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/app/app_prefs.dart';
import 'package:fota_mobile_app/app/constants.dart';
import 'package:fota_mobile_app/domain/usecase/get_user_data_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/update_user_usecase.dart';

import '../../../domain/model/model.dart';
import '../../../domain/usecase/base_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserDataUseCase _getUserData;
  final UpdateUserDataUseCase _updateUser;
  final AppPreferences _appPreferences;
  UserCubit(this._getUserData, this._appPreferences, this._updateUser)
      : super(UserInitial());

  Future<void> getMyData() async {
    emit(UserDataLoadingState());
    (await _getUserData.execute(NoParams())).fold((failure) {
      emit(UserDataErrorState(errorMessage: failure.message));
    }, (user) {
      userData = user;
      emit(UserDataLoadedState(userData: user));
      updateFcmToken(user);
    });
  }

  User? userData;

  void updateFcmToken(user) async {
    if(user.deviceToken != Constants.fcmToken){
      (await _updateUser.execute(UpdateUserInput(
            userData!.fullname, userData!.profileImage, Constants.fcmToken!)))
        .fold((failure) {
      emit(UserDataErrorState(errorMessage: failure.message));
    }, (user) {
      userData = user;
      emit(UserDataLoadedState(userData: user));
    });
    }
    
  }

  Future<void> resetUserData() async {
    //* RESET
    await _appPreferences.clearAllMyData().then((_) => emit(UserInitial()));
  }
}
