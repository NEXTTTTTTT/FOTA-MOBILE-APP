import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SearchUserDataUseCase extends BaseUseCase<String,List<User>> {
  final Repository _repository;
  SearchUserDataUseCase(this._repository);

  @override
  Future<Either<Failure, List<User>>> execute(String input) async {
    return await _repository.searchUser(input);
  }
}
