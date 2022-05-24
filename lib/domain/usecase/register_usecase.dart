import '../../data/network/failure.dart';
import 'package:dartz/dartz.dart';
import '../../data/request/request.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';



class RegisterUseCase implements BaseUseCase<RegisterUserCaseInput, Authentication> {

   final Repository _repository;
    RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUserCaseInput input)async {
    return await _repository.register(RegisterRequest(input.fullname, input.username, input.email, input.password));
  }
}

class RegisterUserCaseInput {
  String fullname;
  String username;
  String email;
  String password;
  RegisterUserCaseInput(this.fullname,this.username,this.email, this.password);
}
