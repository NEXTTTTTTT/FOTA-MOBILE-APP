import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartz/dartz.dart';
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
  Future<Either<Failure, List<Car>>> getMyCars(String id) async {
    try {
      // get from cache
      final response = await _localDataSource.getMyCars(id);
      return Right(response.toDomain());
    } catch (cacheError) {
      // call api
      if (await _networkInfo.isConnected) {
        try {
          // safe to call APIs
          final response = await _remoteDataSource.getMyCars(id);

          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // save data to cache
            _localDataSource.saveMyCarsToCache(response, id);
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
  Future<Either<Failure, User>> getUserData(String id) async {
    try {
      final response = await _localDataSource.getUserData(id);
      return Right(response.toDomain());
    } catch (cacheError) {
      // call apis
      if (await _networkInfo.isConnected) {
        try {
          // safe to call APIs
          final response = await _remoteDataSource.getUserData(id);

          if (response.status == ApiInternalStatus.SUCCESS) {
            // success
            // save data to cache
            _localDataSource.saveUserDataToCache(response, id);
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
  Future<Either<Failure, Authentication>> refreshToken(refreshToken)async  {
  
      if (await _networkInfo.isConnected) {
        try {
          // safe to call APIs
          final response = await _remoteDataSource.refreshToken(refreshToken);

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
}
