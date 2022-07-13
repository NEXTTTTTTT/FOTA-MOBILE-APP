part of 'car_cubit.dart';

abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object> get props => [];
}

class CarInitial extends CarState {}

//*  CARS STATES
class MyCarsLoadingState extends CarState {}

class MyCarsLoadedState extends CarState {
  final List<Car> myCars;

  const MyCarsLoadedState(this.myCars);
}

class MyCarsErrorState extends CarState {
  final String errorMessage;

  const MyCarsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ConnectCarLoadingState extends CarState {}

class ConnectCarSuccessState extends CarState {}

class ConnectCarErrorState extends CarState {
  final String msg;

  const ConnectCarErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
