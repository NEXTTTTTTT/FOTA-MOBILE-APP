part of 'mqtt_cubit.dart';

abstract class MqttState extends Equatable {
  const MqttState();

  @override
  List<Object> get props => [];
}

class MqttInitial extends MqttState {}
class MqttConnectedState extends MqttState {}
class MqttDisConnectedState extends MqttState {}
class MqttConnectingState extends MqttState {}
class MqttReceivedText extends MqttState {
}

