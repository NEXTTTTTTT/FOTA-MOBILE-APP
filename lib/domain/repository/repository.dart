import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../model/model.dart';


abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}