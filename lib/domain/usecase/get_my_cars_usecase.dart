import 'package:dartz/dartz.dart';
import '../model/model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetMyCarsUseCase implements BaseUseCase<String,List<Car>>{

  final Repository _repository;
  GetMyCarsUseCase(this._repository);
  @override
  Future<Either<Failure, List<Car>>> execute(String input) async{
    return await _repository.getMyCars(input);
  }
}


