part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class CarsDetailsPageIndexChangedSuccessState extends AppState {
  final int index;

  const CarsDetailsPageIndexChangedSuccessState(this.index);
  @override
  List<Object> get props => [index];
}
