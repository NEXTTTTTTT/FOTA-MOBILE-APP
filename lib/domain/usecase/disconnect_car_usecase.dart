import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/domain/repository/repository.dart';
import 'package:fota_mobile_app/domain/usecase/base_usecase.dart';

import '../model/model.dart';

class DisConnectCarUseCase extends BaseUseCase<DisConnectCarInput, List<Car>> {
  final Repository _repository;

  DisConnectCarUseCase(this._repository);
  @override
  Future<Either<Failure, List<Car>>> execute(DisConnectCarInput input) async {
    return await _repository.disconnectCar(input);
  }
}

class DisConnectCarInput extends Equatable {
  final String code;
  final String password;

  const DisConnectCarInput(this.code, this.password);

  @override
  List<Object> get props => [code, password];
}
