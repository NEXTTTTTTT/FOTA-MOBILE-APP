import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:fota_mobile_app/presentation/bussiness_logic/map_cubit/map_cubit.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bussiness_logic/car_cubit/car_cubit.dart';
import '../../../bussiness_logic/position_cubit/position_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    
    return BlocBuilder<CarCubit, CarState>(
      builder: (context, state) {
        if (state is MyCarsLoadedState) {
          return MyGoogleMapWidget();
        } else {
          return const Center(child: Text('LOADING'),);
        }
      },
    );
  }
}

class MyGoogleMapWidget extends StatelessWidget {
  MyGoogleMapWidget({
    Key? key,
  }) : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final _mapCubit = BlocProvider.of<MapCubit>(context);
    final _positionBloc = BlocProvider.of<PositionCubit>(context);
    return _positionBloc.myPosition != null
        ? GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_positionBloc.myPosition!.latitude,
                    _positionBloc.myPosition!.longitude),
                zoom: 7),
            onMapCreated: (controller) {
              _controller.complete(controller);
              // _bloc.add(SetMarkersEvent());
            },
            markers: _mapCubit.markers,
          )
        : Container();
  }
}
