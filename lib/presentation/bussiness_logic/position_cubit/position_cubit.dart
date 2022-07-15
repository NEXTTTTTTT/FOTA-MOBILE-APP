import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/app/extentions.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/car_cubit/car_cubit.dart';
import 'package:geolocator/geolocator.dart';

import '../map_cubit/map_cubit.dart';

part 'position_state.dart';

class PositionCubit extends Cubit<PositionState> {
  final MapCubit _mapCubit;

  PositionCubit(
    this._mapCubit,
  ) : super(PositionInitial());

  void getPostition() async {
    emit(UserPositionLoadingState());
    await Geolocator().getCurrentPosition().then((position) async {
      // update position attribute
      myPosition = position;

      // call setCurrentLocationMarker and pass location to it
      _mapCubit.setMyCurrentLocationMarker(position);
      // get placemark
      await _getMyPlaceMark(position)
          .then((_) => emit(UserPositionLoadedState(position: position)));
    }).catchError((err) {
      emit(UserPositionErrorState(errorMessage: err.toString()));
    });
  }

  Position? myPosition;
  String? myPlacemark;

  Future<void> _getMyPlaceMark(position) async {
    var placeMarks = await Geolocator().placemarkFromPosition(position);
    myPlacemark = placeMarks[0].toAddress();
  }

  void resetPosition() {
    myPosition = null;
    myPlacemark = null;
    emit(PositionInitial());
  }
}
