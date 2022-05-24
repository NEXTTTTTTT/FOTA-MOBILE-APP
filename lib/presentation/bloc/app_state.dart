part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class InitialState extends AppState {}

//*  CARS STATES
class MyCarsLoadingState extends AppState {}

class MyCarsLoadedState extends AppState {
  final List<Car> myCars;

  const MyCarsLoadedState(this.myCars);
}

class MyCarsErrorState extends AppState {
  final String errorMessage;

  const MyCarsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class MyCarsEmptyState extends AppState {}

//*  USER DATA STATE
class UserDataLoadingState extends AppState {}

class UserDataLoadedState extends AppState {
  final User userData;

  const UserDataLoadedState({required this.userData});

  @override
  List<Object> get props => [userData];
}

class UserDataErrorState extends AppState {
  final String errorMessage;

  const UserDataErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
