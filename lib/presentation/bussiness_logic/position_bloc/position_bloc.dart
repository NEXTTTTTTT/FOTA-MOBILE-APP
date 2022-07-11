import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fota_mobile_app/app/extentions.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/cars_bloc/cars_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../map_cubit/map_cubit.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  final MapCubit _mapCubit;
  final CarsBloc _carsBloc;
  PositionBloc(this._mapCubit, this._carsBloc) : super(PositionInitialState()) {

    
    on<PositionEvent>((event, emit) async {
      //*  GET MY POSITION
      if (event is GetMyPositionEvent) {
        emit(UserPositionLoadingState());
        await Geolocator().getCurrentPosition().then((position) {
          emit(UserPositionLoadedState(position: position));
          // update position attribute
          myPosition = position;
          // get cars
          _carsBloc.add( GetMyCarsEvent(position: position));
          print(position.toString()+ "kfffffffkkdkkdkkdkk");
          // get placemark
          _getMyPlaceMark(position);
          // call setCurrentLocationMarker and pass location to it
          _mapCubit.setMyCurrentLocationMarker(position);
        });
      }
    });
  }


  Position? myPosition;
  String? myPlacemark;

  void _getMyPlaceMark(position) async {
    var placeMarks = await Geolocator().placemarkFromPosition(position);
    myPlacemark = placeMarks[0].toAddress();
  }
}
