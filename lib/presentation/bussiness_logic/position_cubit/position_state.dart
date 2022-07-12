part of 'position_cubit.dart';

abstract class PositionState extends Equatable {
  const PositionState();

  @override
  List<Object> get props => [];
}

class PositionInitial extends PositionState {}

//*  USER LOCATION
class UserPositionLoadingState extends PositionState {}

class UserPositionLoadedState extends PositionState {
  final Position position;

  const UserPositionLoadedState({required this.position});

  @override
  List<Object> get props => [position];
}

class UserPositionErrorState extends PositionState {
  final String errorMessage;

  const UserPositionErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

//*  MARKERS
class MarkersLoadingState extends PositionState {}

class MarkersLoadedState extends PositionState {}