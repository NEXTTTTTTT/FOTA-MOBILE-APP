import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SearchUserDataUseCase extends BaseUseCase<SearchUserInput, List<User>> {
  final Repository _repository;
  SearchUserDataUseCase(this._repository);

  @override
  Future<Either<Failure, List<User>>> execute(SearchUserInput input) async {
    return await _repository.searchUser(input);
  }
}

class SearchUserInput {
  final String username;
  final String code;

  SearchUserInput(this.username, this.code);
}
