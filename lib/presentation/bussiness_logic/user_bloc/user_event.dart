part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetMyDataEvent extends UserEvent {
  final String? uid;

  const GetMyDataEvent({this.uid});
  @override
  List<Object> get props => [];
}

class ResetBlocEvent extends UserEvent{}
