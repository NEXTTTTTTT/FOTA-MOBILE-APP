import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetUserDataUseCase extends BaseUseCase<NoParams,User> {
  final Repository _repository;
  GetUserDataUseCase(this._repository);

  @override
  Future<Either<Failure, User>> execute(NoParams input) async {
    return await _repository.getUserData(input);
  }
}
