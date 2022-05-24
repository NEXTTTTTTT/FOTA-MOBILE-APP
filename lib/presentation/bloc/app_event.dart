part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class GetMyDataEvent extends AppEvent {
  final String uid;

  const GetMyDataEvent(this.uid);
  @override
  List<Object> get props => [uid];
}

class GetMyCarsEvent extends AppEvent {
  final String uid;

  const GetMyCarsEvent(this.uid);
   @override
  List<Object> get props => [uid];
}
