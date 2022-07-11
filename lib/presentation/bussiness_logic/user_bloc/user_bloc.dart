import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../app/constants.dart';
import '../../../domain/model/model.dart';
import '../../../domain/usecase/get_user_data_usecase.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserDataUseCase _getUserData;
  UserBloc(
    this._getUserData,
  ) : super(UserInitialState()) {
    on<UserEvent>((event, emit) async {

      //*  GET USER DATA EVENT
      if (event is GetMyDataEvent) {
        emit(UserDataLoadingState());
        (await _getUserData.execute(event.uid ?? Constants.myId!)).fold(
            (failure) {
          emit(UserDataErrorState(errorMessage: failure.message));
        }, (userData) {
          emit(UserDataLoadedState(userData: userData));
        });
      }

      //* RESET
      else if (event is ResetBlocEvent) {
        emit(UserInitialState());
      }
    });
  }
}
