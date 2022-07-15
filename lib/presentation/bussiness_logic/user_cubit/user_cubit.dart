import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/app/app_prefs.dart';
import 'package:fota_mobile_app/domain/usecase/get_user_data_usecase.dart';

import '../../../app/constants.dart';
import '../../../domain/model/model.dart';
import '../../../domain/usecase/base_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserDataUseCase _getUserData;
  final AppPreferences _appPreferences;
  UserCubit(this._getUserData, this._appPreferences) : super(UserInitial());

  Future<void> getMyData() async {
    emit(UserDataLoadingState());
    (await _getUserData.execute(NoParams())).fold((failure) {
      emit(UserDataErrorState(errorMessage: failure.message));
    }, (userData) {
      this.userData = userData;
      emit(UserDataLoadedState(userData: userData));
    });
  }

  User? userData;

  Future<void> resetUserData() async {
    //* RESET
    await _appPreferences.clearAllMyData().then((_) => emit(UserInitial()));
  }
}
