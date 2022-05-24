import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';


class RefreshTokenUseCase implements BaseUseCase<String, Authentication> {
  final Repository _repository;
  RefreshTokenUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(refreshToken) async {
    return await _repository.refreshToken(refreshToken);
  }
}
