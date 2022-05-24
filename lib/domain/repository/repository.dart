 
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../model/model.dart';


abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);
Future<Either<Failure,Authentication>> refreshToken(String refreshToken);

  Future<Either<Failure,List<Car>>> getMyCars(String id);
  Future<Either<Failure,User>> getUserData(String id);
}