import 'package:dartz/dartz.dart';
import '../../data/request/request.dart';

import '../../app/functions.dart';
import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';


class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{

  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
    return await _repository.login(LoginRequest(input.email, input.password,));
  }

}

class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}

