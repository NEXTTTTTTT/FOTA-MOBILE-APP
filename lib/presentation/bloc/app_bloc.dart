import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/app/app_prefs.dart';
import 'package:fota_mobile_app/app/constants.dart';
import 'package:fota_mobile_app/domain/model/model.dart';
import 'package:fota_mobile_app/domain/usecase/get_my_cars_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/get_user_data_usecase.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GetMyCarsUseCase _getMyCars;
  final GetUserDataUseCase _getUserData;
  final AppPreferences _appPref;

  AppBloc(this._getMyCars, this._getUserData, this._appPref)
      : super(InitialState()) {

        
    on<AppEvent>((event, emit) async {
      //*  GET MY CARS EVENT
      if (event is GetMyCarsEvent) {
        emit(MyCarsLoadingState());
        (await _getMyCars.execute(event.uid)).fold((failure) {
          emit(MyCarsErrorState(errorMessage: failure.message));
        }, (myCars) {
          if (myCars.isEmpty) {
            emit(MyCarsEmptyState());
          } else {
            emit(MyCarsLoadedState(myCars));
          }
        });
      }
      //*  GET USER DATA EVENT
      else if (event is GetMyDataEvent) {
        emit(UserDataLoadingState());
        (await _getUserData.execute(event.uid)).fold((failure) {
          emit(UserDataErrorState(errorMessage: failure.message));
        }, (userData) {
          emit(UserDataLoadedState(userData: userData));
        });
      }
    });
  }
}
