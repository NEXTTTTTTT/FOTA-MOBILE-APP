import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/domain/usecase/connect_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/share_car_usecase.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../model/model.dart';
import '../usecase/base_usecase.dart';
import '../usecase/disconnect_car_usecase.dart';
import '../usecase/remove_user_away_my_car_usecase.dart';
import '../usecase/update_user_usecase.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, Authentication>> refreshToken(String refreshToken);

  Future<Either<Failure, List<Car>>> getMyCars(NoParams input);
  Future<Either<Failure, User>> getUserData(NoParams input);
  Future<Either<Failure, List<User>>> searchUser(String username);
  Future<Either<Failure, User>> updateUser(UpdateUserInput input);

  Future<Either<Failure, List<Car>>> connectCar(ConnectCarInput input);
  Future<Either<Failure, List<Car>>> disconnectCar(DisConnectCarInput input);
  Future<Either<Failure, List<Car>>> sharedCar(ShareCarInput input);
  Future<Either<Failure, List<Car>>> removeUserAwayMyCar(
      RemoveUserAwayMyCarInput input);
      Future<Either<Failure, List<Car>>> unshareCar(
      String input);
}
