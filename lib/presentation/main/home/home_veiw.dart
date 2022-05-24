import 'dart:async';


import 'package:flutter/material.dart';
import 'package:fota_mobile_app/app/constants.dart';
import 'package:fota_mobile_app/presentation/main/home/home_view_model.dart';
import 'package:geolocator/geolocator.dart';

import '../../../app/di.dart';
import '../../../domain/model/model.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';

import '../../resources/routes_manager.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  _bind() {
    _homeViewModel.start();
    _homeViewModel.getMyCars();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _homeViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _homeViewModel.start();
              }) ??
              _getContentWidget();
        });
  }

  Widget _getContentWidget() {
    return StreamBuilder<List<Car>>(
        stream: _homeViewModel.outputMyCarsList,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Stack(
                  children: [
                    MyGoogleMapWidget(cars: snapshot.data!),
                  ],
                )
              : Container();
        });
  }
}

class MyGoogleMapWidget extends StatefulWidget {
  final List<Car> cars;
  const MyGoogleMapWidget({Key? key, required this.cars}) : super(key: key);

  @override
  State<MyGoogleMapWidget> createState() => _MyGoogleMapWidgetState();
}

class _MyGoogleMapWidgetState extends State<MyGoogleMapWidget> {
  Completer<GoogleMapController> controller1 = Completer();

  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  static LatLng? _initialPosition;
  final Set<Marker> _markers = {};
  static LatLng? _lastMapPosition = _initialPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _getCustomCarIconMarker();
    _getCustomUserIconMarker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
        
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
      _setMyCurrentLocationMarker();
      _setCarMarkers();
    });
  }

  BitmapDescriptor? carMarker;
  void _getCustomCarIconMarker() async {
    var _icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1), devicePixelRatio: 3.2),
        AssetsManager.carMarkerBlue);

    carMarker = _icon;
  }

  BitmapDescriptor? userMarker;
  void _getCustomUserIconMarker() async {
    var _icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(1, 1), devicePixelRatio: 3.2),
        AssetsManager.userMarker);

    userMarker = _icon;
  }

  bool _isLocationValid(location) {
    return location != null &&
        location['lat'] != null &&
        location['lng'] != null;
  }

  _setCarMarkers() {
    for (Car car in widget.cars) {
      if (_isLocationValid(car.carLocation)) {
        _markers.add(Marker(
          markerId: MarkerId(car.id),
          position: LatLng(double.parse(car.carLocation['lat']),
              double.parse(car.carLocation['lng'])),
          infoWindow: InfoWindow(
            title: car.carType + " " + car.code + ' (${car.admin!.username})',
            snippet: (car.isActive ? 'Active' : 'Offline') +
                ' | ' +
                '${car.currentSpeed.toString()} KM/H',
            onTap: () {
              Constants.defaultCar = car;
              Navigator.of(context).pushNamed(Routes.carDetailsRoute);
            },
          ),
          icon: carMarker!,
        ));
      }
    }
  }

  _setMyCurrentLocationMarker() {
    if (_initialPosition != null) {
      _markers.add(Marker(
        markerId: const MarkerId('1'),
        position:
            LatLng(_initialPosition!.latitude, _initialPosition!.longitude),
        infoWindow: InfoWindow(
          title: 'You',
          snippet: 'Get My Nearest Car',
          onTap: () {
            // TODO: navigate to nearest car
          },
        ),
        icon: userMarker!,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _initialPosition != null
        ? GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _initialPosition!, zoom: 7),
            onMapCreated: _onMapCreated,
            markers: _markers,
          )
        : Container();
  }
}
