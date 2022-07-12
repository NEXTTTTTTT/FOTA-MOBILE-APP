part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}
//*  USER DATA STATE
class UserDataLoadingState extends UserState {}

class UserDataLoadedState extends UserState {
  final User userData;

  const UserDataLoadedState({required this.userData});

  @override
  List<Object> get props => [userData];
}

class UserDataErrorState extends UserState {
  final String errorMessage;

  const UserDataErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}