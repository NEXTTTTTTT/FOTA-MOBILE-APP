import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/domain/repository/repository.dart';
import 'package:fota_mobile_app/domain/usecase/base_usecase.dart';

import '../model/model.dart';

class UnShareCarUseCase extends BaseUseCase<String, List<Car>> {
  final Repository _repository;

  UnShareCarUseCase(this._repository);
  @override
  Future<Either<Failure,  List<Car>>> execute(String input) async {
    return await _repository.unshareCar(input);
  }
}


