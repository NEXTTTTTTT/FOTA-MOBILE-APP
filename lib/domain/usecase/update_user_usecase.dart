import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class UpdateUserDataUseCase extends BaseUseCase<UpdateUserInput, User> {
  final Repository _repository;
  UpdateUserDataUseCase(this._repository);

  @override
  Future<Either<Failure, User>> execute(UpdateUserInput input) async {
    return await _repository.updateUser(input);
  }
}

class UpdateUserInput extends Equatable {
  final String fullname;
  final String profileImage;
  final String deviceToken;

  const UpdateUserInput(this.fullname, this.profileImage, this.deviceToken);
  
  @override
  List<Object> get props => [fullname,profileImage,deviceToken];
}
