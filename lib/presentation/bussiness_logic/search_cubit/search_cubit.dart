import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/domain/usecase/search_user_usecase.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/car_cubit/car_cubit.dart';

import '../../../domain/model/model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUserDataUseCase _searchUsers;
  final CarCubit _carCubit;
  StreamSubscription? mycarsUpdating;
  SearchCubit(this._searchUsers, this._carCubit) : super(SearchInitial());

  List<User> filteredUsers = [];

  void searchUsers(String username) async {
    emit(SearchLoadingState());
    (await _searchUsers
            .execute(SearchUserInput(username, _carCubit.selectedCarCode!)))
        .fold((failure) {
      emit(SearchErrorState(failure.message));
    }, (users) {
      filteredUsers = users;
      emit(SearchSuccessState(filteredUsers));
    });
  }

  void removeUserFromSearch(User user) {
    filteredUsers.remove(user);
    emit(SearchRemoveUserState(user));
  }
}
