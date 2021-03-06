import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fota_mobile_app/app/extentions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/constants.dart';
import '../../../app/functions.dart';
import '../../../domain/model/model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial()) {
    //*  SETUP ICONS
    _setUpMyMarkersIcons().whenComplete(() => emit(SetMarkerIconsSuccessState(
        carMarkerIcon: carMarkerIcon!, userMarkerIcon: userMarkerIcon!)));
  }

  // markers icons
  BitmapDescriptor? carMarkerIcon;
  BitmapDescriptor? userMarkerIcon;

  // markers
  final Set<Marker> markers = {};

  // selected car
  String? selectedCarCodeToBeShown;

  Future<void> _setUpMyMarkersIcons() async {
    await _setCustomCarIconMarker();
    await _setCustomUserIconMarker();
  }

  Future<void> _setCustomCarIconMarker() async {
    var _icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1), devicePixelRatio: 3.2),
        AssetsManager.carMarkerBlue);

    carMarkerIcon = _icon;
  }

  Future<void> _setCustomUserIconMarker() async {
    var _icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1), devicePixelRatio: 3.2),
        AssetsManager.userMarker);

    userMarkerIcon = _icon;
  }

  void setCarsMarkers(List<Car> myCarsData) {
    debugPrint('${myCarsData.length}');
    for (Car car in myCarsData) {
      LatLng? loc = nmeaToDecimal(car.carLocation);
      if (loc !=null) {
        markers.add(Marker(
          markerId: MarkerId(car.id),
          position: loc,
          infoWindow: InfoWindow(
            title: car.carType + " " + car.code,
            snippet: (car.isMotorOn ? 'Running' : 'Available') +
                ' | ' +
                ' ${car.admin!.username}',
            onTap: () {
              selectedCarCodeToBeShown = car.code;
              emit(WindowOnTapChangeCarSelected(car.code));
              Constants.navigatorKey.currentState!
                  .pushNamed(Routes.carDetailsRoute);
            },
          ),
          icon: carMarkerIcon!,
        ));
      }
    }
    emit(SetCarMarkerSuccessState());
  }

  void setMyCurrentLocationMarker(
    myPosition,
  ) {
    if (myPosition != null) {
      markers.add(Marker(
        markerId: const MarkerId('1'),
        position: LatLng(myPosition!.latitude, myPosition!.longitude),
        infoWindow: InfoWindow(
          title: 'You',
          snippet: 'look for available cars',
          onTap: () {},
        ),
        icon: userMarkerIcon!,
      ));
    }
    emit(SetMyPositionMarkerSuccessState());
  }

  void resetMap() {
    markers.clear();
    emit(MapInitial());
  }
}
