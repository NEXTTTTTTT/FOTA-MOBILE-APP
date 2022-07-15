import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/app/extentions.dart';
import 'package:fota_mobile_app/domain/usecase/base_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/connect_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/remove_user_away_my_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/share_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/unshare_car_usecase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/functions.dart';
import '../../../domain/model/model.dart';
import '../../../domain/usecase/disconnect_car_usecase.dart';
import '../../../domain/usecase/get_my_cars_usecase.dart';
import '../map_cubit/map_cubit.dart';
import '../position_cubit/position_cubit.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  final GetMyCarsUseCase _getMyCars;
  final ConnectCarUseCase _connectCar;
  final DisConnectCarUseCase _disconnectCar;
  final ShareCarUseCase _shareCar;
  final UnShareCarUseCase _unshareCar;
  final RemoveUserAwayMyCarUseCase _removeUserAwayMyCar;
  final MapCubit _mapCubit;
  final PositionCubit _positionCubit;
  StreamSubscription? mapOnWindowTap;
  StreamSubscription? positionChange;
  CarCubit(
      this._getMyCars,
      this._mapCubit,
      this._connectCar,
      this._positionCubit,
      this._disconnectCar,
      this._shareCar,
      this._unshareCar,
      this._removeUserAwayMyCar)
      : super(CarInitial()) {
    _mapCubit.stream.listen((state) {
      if (state is WindowOnTapChangeCarSelected) {
        selectedCarCode = state.code;
      }
    });

    _positionCubit.stream.listen((state) {
      if (state is UserPositionLoadedState) {
        _position = state.position;
        getMyCars();
      }
    });
  }

  void removeUserAwayMyCar(String userId, String carId) async {
    myCarsData
        .singleWhere((car) => car.code == selectedCarCode)
        .users!
        .removeWhere(
          (user) => user.id == userId,
        );
    emit(MyCarsLoadingState());
    (await _removeUserAwayMyCar.execute(
      RemoveUserAwayMyCarInput(userId, carId),
    ))
        .fold((failure) {
      emit(MyCarsErrorState(errorMessage: failure.message));
    }, (myCars) {
      // update attributes
      myCarsData = myCars;
      _resetMapData(myCars).then((value) => emit(MyCarsLoadedState(myCars)));
    });
  }

  void unshareCar(String carId) async {
    emit(MyCarsLoadingState());
    (await _unshareCar.execute(carId)).fold((failure) {
      emit(MyCarsErrorState(errorMessage: failure.message));
    }, (myCars) {
      // update attributes
      myCarsData = myCars;
      _resetMapData(myCars).then((value) => emit(MyCarsLoadedState(myCars)));
    });
  }

  void shareCar(String userId, String carId) async {
    emit(MyCarsLoadingState());
    (await _shareCar.execute(ShareCarInput(
      userId,
      carId,
    )))
        .fold((failure) {
      emit(MyCarsErrorState(errorMessage: failure.message));
    }, (myCars) {
      // update attributes
      myCarsData = myCars;
      _resetMapData(myCars).then((value) => emit(MyCarsLoadedState(myCars)));
    });
  }

  void disconnectCar(String code, String password) async {
    emit(MyCarsLoadingState());
    (await _disconnectCar.execute(DisConnectCarInput(
      code,
      password,
    )))
        .fold((failure) {
      emit(MyCarsErrorState(errorMessage: failure.message));
    }, (myCars) {
      // update attributes
      myCarsData = myCars;
      _resetMapData(myCars).then((value) => emit(MyCarsLoadedState(myCars)));
    });
  }

  void connectCar(String code, String password, String name) async {
    emit(MyCarsLoadingState());
    (await _connectCar.execute(ConnectCarInput(code, password, name))).fold(
        (failure) {
      emit(MyCarsErrorState(errorMessage: failure.message));
    }, (myCars) {
      // update attributes
      myCarsData = myCars;
      _resetMapData(myCars).then((value) => emit(MyCarsLoadedState(myCars)));
    });
  }

  void getMyCars() async {
    emit(MyCarsLoadingState());
    (await _getMyCars.execute(NoParams())).fold((failure) {
      emit(MyCarsErrorState(errorMessage: failure.message));
    }, (myCars) {
      // update attributes
      myCarsData = myCars;
      _resetMapData(myCars).then((value) => emit(MyCarsLoadedState(myCars)));
    });
  }

  Future<void> _resetMapData(myCars) async {
    // update cars marker
    _setCarDistanceFromMe(_position!);
    await _setCarPlacemark();
    _mapCubit.setCarsMarkers(myCars);
  }

  List<Car> myCarsData = [];
  String? selectedCarCode;
  Position? _position;

  _setCarDistanceFromMe(Position position) async {
    for (Car car in myCarsData) {
      if (isLocationValid(car.carLocation)) {
        var carLatLng = _mapToLatLng(car.carLocation);
        car.distanceBetween = (await Geolocator().distanceBetween(
              position.latitude,
              position.longitude,
              carLatLng!.latitude,
              carLatLng.longitude,
            ))
                .round() /
            1000;
      } else {
        car.distanceBetween = null;
      }
    }
  }

  _setCarPlacemark() async {
    for (Car car in myCarsData) {
      if (isLocationValid(car.carLocation)) {
        var carLatLng = _mapToLatLng(car.carLocation);
        var placemarks = await Geolocator().placemarkFromCoordinates(
          carLatLng!.latitude,
          carLatLng.longitude,
        );
        car.placemark = placemarks[0].toAddress();
      } else {
        car.placemark = null;
      }
    }
  }

  LatLng? _mapToLatLng(Map carLocation) {
    if (isLocationValid(carLocation)) {
      double lat = double.parse(carLocation['lat']);
      double lng = double.parse(carLocation['lng']);
      return LatLng(lat, lng);
    } else {
      return null;
    }
  }

  @override
  Future<void> close() {
    mapOnWindowTap?.cancel();
    positionChange?.cancel();
    return super.close();
  }

  void resetMyCars() {
    myCarsData.clear();
    _position = null;
    emit(CarInitial());
  }
}
