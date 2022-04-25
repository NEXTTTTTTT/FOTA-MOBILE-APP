import 'package:fota_mobile_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/data/request/request.dart';
import 'package:fota_mobile_app/domain/model/model.dart';
import 'package:fota_mobile_app/domain/repository/repository.dart';
import 'package:fota_mobile_app/domain/usecase/base_usecase.dart';



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
