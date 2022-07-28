import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/domain/repository/repository.dart';
import 'package:fota_mobile_app/domain/usecase/base_usecase.dart';

import '../model/model.dart';

class RemoveUserAwayMyCarUseCase extends BaseUseCase<RemoveUserAwayMyCarInput, List<Car>> {
  final Repository _repository;

  RemoveUserAwayMyCarUseCase(this._repository);
  @override
  Future<Either<Failure,  List<Car>>> execute(RemoveUserAwayMyCarInput input) async {
    return await _repository.removeUserAwayMyCar(input);
  }
}

class RemoveUserAwayMyCarInput extends Equatable {
  final String userId;
  final String code;

  const RemoveUserAwayMyCarInput(this.userId, this.code);

  @override
  List<Object> get props => [userId, code];
}
