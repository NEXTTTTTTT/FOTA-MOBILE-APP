part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class SetMarkerIconsSuccessState extends MapState {
  final BitmapDescriptor carMarkerIcon;
  final BitmapDescriptor userMarkerIcon;

  const SetMarkerIconsSuccessState(
      {required this.carMarkerIcon, required this.userMarkerIcon});

  @override
  List<Object> get props => [carMarkerIcon, userMarkerIcon];
}

class SetCarMarkerSuccessState extends MapState {}

class SetMyPositionMarkerSuccessState extends MapState {}

class WindowOnTapChangeCarSelected extends MapState {
  final String code;

  const WindowOnTapChangeCarSelected(this.code);
  @override
  List<Object> get props => [code];
}
