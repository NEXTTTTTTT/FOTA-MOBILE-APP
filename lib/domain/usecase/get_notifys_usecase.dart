import 'package:fota_mobile_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/domain/model/model.dart';
import 'package:fota_mobile_app/domain/repository/repository.dart';
import 'package:fota_mobile_app/domain/usecase/base_usecase.dart';

class GetNotifysUseCase extends BaseUseCase< NoParams,List<Notify>> {
  GetNotifysUseCase(this._repository);

  final Repository _repository;

  @override
  Future<Either<Failure, List<Notify>>> execute(input)async {
    return await _repository.getNotifys(input);
  }

}