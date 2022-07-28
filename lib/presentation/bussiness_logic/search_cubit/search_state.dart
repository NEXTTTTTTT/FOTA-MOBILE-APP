part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String errorMsg;

  const SearchErrorState(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}

class SearchSuccessState extends SearchState {
  final List<User> users;
  const SearchSuccessState(this.users);
  @override
  List<Object> get props => [users];
}

class SearchRemoveUserState extends SearchState {
  final User user;
  const SearchRemoveUserState(this.user);
  @override
  List<Object> get props => [user];
}
