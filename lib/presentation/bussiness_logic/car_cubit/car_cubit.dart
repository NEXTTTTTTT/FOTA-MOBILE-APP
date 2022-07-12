import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/app/extentions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/constants.dart';
import '../../../app/functions.dart';
import '../../../domain/model/model.dart';
import '../../../domain/usecase/get_my_cars_usecase.dart';
import '../map_cubit/map_cubit.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
   final GetMyCarsUseCase _getMyCars;
  final MapCubit _mapCubit;
  CarCubit(this._getMyCars, this._mapCubit) : super(CarInitial());

  void getMyCars(Position position)async {
     emit(MyCarsLoadingState());
        (await _getMyCars.execute( Constants.myId!)).fold(
            (failure) {
          emit(MyCarsErrorState(errorMessage: failure.message));
        }, (myCars) {
          emit(MyCarsLoadedState(myCars));
          // update attributes
          myCarsData = myCars;
          // update cars marker
          _mapCubit.setCarsMarkers(myCars);
          setCarDistanceFromMe(position);
          setCarPlacemark();
        });
  }

   List<Car>? myCarsData;

  setCarDistanceFromMe(Position position) async {
    for (Car car in myCarsData!) {
      if (isLocationValid(car.carLocation)) {
        var carLatLng = mapToLatLng(car.carLocation);
        car.distanceBetween = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          carLatLng!.latitude,
          carLatLng.longitude,
        );
      } else {
        car.distanceBetween = null;
      }
    }
  }

  setCarPlacemark() async {
    for (Car car in myCarsData!) {
      if (isLocationValid(car.carLocation)) {
        var carLatLng = mapToLatLng(car.carLocation);
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

  LatLng? mapToLatLng(Map carLocation) {
    if (isLocationValid(carLocation)) {
      double lat = double.parse(carLocation['lat']);
      double lng = double.parse(carLocation['lng']);
      return LatLng(lat, lng);
    } else {
      return null;
    }
  }
}
