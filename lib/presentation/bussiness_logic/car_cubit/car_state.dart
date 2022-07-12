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
