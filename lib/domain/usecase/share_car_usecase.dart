import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/domain/repository/repository.dart';
import 'package:fota_mobile_app/domain/usecase/base_usecase.dart';

import '../model/model.dart';

class ShareCarUseCase extends BaseUseCase<ShareCarInput, List<Car>> {
  final Repository _repository;

  ShareCarUseCase(this._repository);
  @override
  Future<Either<Failure,  List<Car>>> execute(ShareCarInput input) async {
    return await _repository.sharedCar(input);
  }
}

class ShareCarInput extends Equatable {
  final String userId;
  final String code;

  const ShareCarInput(this.userId, this.code);

  @override
  List<Object> get props => [userId, code];
}
