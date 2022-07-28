import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetMyCarsUseCase implements BaseUseCase<NoParams,List<Car>>{

  final Repository _repository;
  GetMyCarsUseCase(this._repository);
  @override
  Future<Either<Failure, List<Car>>> execute(NoParams input) async{
    return await _repository.getMyCars(input);
  }
}


