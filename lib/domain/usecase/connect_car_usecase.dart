import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/domain/repository/repository.dart';
import 'package:fota_mobile_app/domain/usecase/base_usecase.dart';

import '../model/model.dart';

class ConnectCarUseCase extends BaseUseCase<ConnectCarInput, List<Car>> {
  final Repository _repository;

  ConnectCarUseCase(this._repository);
  @override
  Future<Either<Failure, List<Car>>> execute(ConnectCarInput input) async {
    return await _repository.connectCar(input);
  }
  
}

class ConnectCarInput extends Equatable {
  final String code;
  final String password;
  final String carName;

  const ConnectCarInput(this.code, this.password, this.carName);

  @override
  List<Object> get props => [code, password,carName];
}
