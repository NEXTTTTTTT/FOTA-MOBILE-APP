part of 'cars_bloc.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object> get props => [];
}

class GetMyCarsEvent extends CarsEvent {
  final String? uid;
  final Position? position;

  const GetMyCarsEvent({this.position, this.uid});
  @override
  List<Object> get props => [];
}
