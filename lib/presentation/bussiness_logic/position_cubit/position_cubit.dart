import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/app/extentions.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/car_cubit/car_cubit.dart';
import 'package:geolocator/geolocator.dart';

import '../map_cubit/map_cubit.dart';

part 'position_state.dart';

class PositionCubit extends Cubit<PositionState> {
  final MapCubit _mapCubit;
  final CarCubit _carsCubit;
  PositionCubit(this._mapCubit, this._carsCubit) : super(PositionInitial());

  void getPostition() async {
    emit(UserPositionLoadingState());
    await Geolocator().getCurrentPosition().then((position) {
      emit(UserPositionLoadedState(position: position));
      // update position attribute
      myPosition = position;
      // get cars
      _carsCubit.getMyCars(position);
      // get placemark
      _getMyPlaceMark(position);
      // call setCurrentLocationMarker and pass location to it
      _mapCubit.setMyCurrentLocationMarker(position);
    }).catchError((err) {
      emit(UserPositionErrorState(errorMessage: err.toString()));
    });
  }

  Position? myPosition;
  String? myPlacemark;

  void _getMyPlaceMark(position) async {
    var placeMarks = await Geolocator().placemarkFromPosition(position);
    myPlacemark = placeMarks[0].toAddress();
  }
}
