import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartz/dartz.dart';
import 'package:fota_mobile_app/data/responses/response.dart';
import 'package:fota_mobile_app/domain/usecase/search_user_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/update_user_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/share_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/remove_user_away_my_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/disconnect_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/connect_car_usecase.dart';
import '../data_source/local_data_source.dart';
import '../mapper/mapper.dart';
import '../network/network_info.dart';
import '../../domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../request/request.dart';
import '../../domain/model/model.dart';

class RepositoryImplementer extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;
  RepositoryImplementer(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return data
          // return right

          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return data
          // return right

          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Car>>> getMyCars(input) async {
    try {
      // get from cache
      final response = await _localDataSource.getMyCars();
      return Right(response.toDomain());
    } catch (cacheError) {
      // call api
      if (await _networkInfo.isConnected) {
        try {
          // safe to call APIs
          final response = await _remoteDataSource.getMyCars();

          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // save data to cache
            _localDataSource.saveMyCarsToCache(response);
            // return data
            // return right

            return Right(response.toDomain());
          } else {
            // return biz logic error
            // return left
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.msg ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        // return connection error
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> getUserData(input) async {
    try {
      final response = await _localDataSource.getUserData();
      return Right(response.toDomain());
    } catch (cacheError) {
      // call apis
      if (await _networkInfo.isConnected) {
        try {
          // safe to call APIs
          final response = await _remoteDataSource.getUserData();

          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // save data to cache
            _localDataSource.saveUserDataToCache(
              response,
            );
            // return data
            // return right
            return Right(response.toDomain());
          } else {
            // return biz logic error
            // return left
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.msg ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        // return connection error
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Authentication>> refreshToken(refreshToken) async {
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response = await _remoteDataSource.refreshToken(refreshToken);

        if (response.status == ApiInternalStatus.SUCCESS) {
          _localDataSource.saveUserDataToCache(
            UserDataResponse(user: response.user!),
          );
          // success
          // return data
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Car>>> connectCar(ConnectCarInput input) async {
    print('hhhhhhhhhhh');
    // call apis
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response = await _remoteDataSource.connectCar(
            input.code, input.password, input.carName);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // save data to cache
          _localDataSource.saveMyCarsToCache(
            response,
          );
          // return data
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Car>>> disconnectCar(
      DisConnectCarInput input) async {
    // call apis
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response =
            await _remoteDataSource.disconnectCar(input.code, input.password);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // save data to cache
          _localDataSource.saveMyCarsToCache(
            response,
          );
          // return data
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Car>>> removeUserAwayMyCar(
      RemoveUserAwayMyCarInput input) async {
    // call apis
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response = await _remoteDataSource.removeUserAwayMyCar(
            input.userId, input.code);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // save data to cache
          _localDataSource.saveMyCarsToCache(
            response,
          );
          // return data
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> searchUser(SearchUserInput input) async {
    // call apis
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response =
            await _remoteDataSource.searchUser(input.username, input.code);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return data
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Car>>> sharedCar(ShareCarInput input) async {
    // call apis
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response =
            await _remoteDataSource.shareCar(input.userId, input.code);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // save data to cache
          _localDataSource.saveMyCarsToCache(
            response,
          );
          // return data
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Car>>> unshareCar(String input) async {
    // call apis
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response = await _remoteDataSource.unshareCar(input);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // save data to cache
          _localDataSource.saveMyCarsToCache(
            response,
          );
          // return data
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(UpdateUserInput input) async {
    // call apis
    if (await _networkInfo.isConnected) {
      try {
        // safe to call APIs
        final response = await _remoteDataSource.updateUser(
            input.fullname, input.profileImage);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // save data to cache
          _localDataSource.saveUserDataToCache(
            response,
          );
          // return data
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.msg ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
