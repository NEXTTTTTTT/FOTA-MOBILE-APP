part of 'cars_bloc.dart';

abstract class CarsState extends Equatable {
  const CarsState();
  
  @override
  List<Object> get props => [];
}

//*  CARS INITIAL STATE
class MyCarsInitialState extends CarsState{}


//*  CARS STATES
class MyCarsLoadingState extends CarsState {}

class MyCarsLoadedState extends CarsState {
  final List<Car> myCars;

  const MyCarsLoadedState(this.myCars);
}

class MyCarsErrorState extends CarsState {
  final String errorMessage;

  const MyCarsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

