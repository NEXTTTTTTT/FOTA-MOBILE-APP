import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

part 'mqtt_state.dart';

class MqttCubit extends Cubit<MqttState> {
  MqttCubit() : super(MqttInitial());

  MqttServerClient? _client;
  final String _identifier = 'mahmoud';
  final String _host = 'broker.emqx.io';
  final String _topic = 'car/#';

  void initializeMQTTClient() {
    _client = MqttServerClient(_host, _identifier);
    _client!.port = 1883;
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = onDisconnected;
    _client!.secure = false;
    _client!.logging(on: true);

    /// Add the successful connection callback
    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    if (kDebugMode) {
      print('EXAMPLE::Mosquitto client connecting....');
    }
    _client!.connectionMessage = connMess;
  }

  void connect() async {
    assert(_client != null);
    try {
      if (kDebugMode) {
        print('EXAMPLE::Mosquitto start client connecting....');
      }
      emit(MqttConnectingState());
      await _client!.connect();
    } on Exception catch (e) {
      if (kDebugMode) {
        print('EXAMPLE::client exception - $e');
      }
      disconnect();
    }
  }

  void disconnect() {
    if (kDebugMode) {
      print('Disconnected');
    }
    _client!.disconnect();
  }

  void publish(String message,String topic) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void onSubscribed(String topic) {
    if (kDebugMode) {
      print('EXAMPLE::Subscription confirmed for topic $topic');
    }
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    if (kDebugMode) {
      print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    }
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      if (kDebugMode) {
        print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
      }
    }
    emit(MqttDisConnectedState());
  }

  /// The successful connect callback
  void onConnected() {
    emit(MqttConnectedState());
    if (kDebugMode) {
      print('EXAMPLE::Mosquitto client connected....');
    }
    _client!.subscribe(_topic, MqttQos.atLeastOnce);
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      // ignore: avoid_as
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      // final MqttPublishMessage recMess = c![0].payload;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _setReceivedText(pt);
      if (kDebugMode) {
        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      }
      if (kDebugMode) {
        print('');
      }
    });
    if (kDebugMode) {
      print(
          'EXAMPLE::OnConnected client callback - Client connection was sucessful');
    }
  }

  String _receivedText = '';
  String _historyText = '';
  void _setReceivedText(String text) {
    _receivedText = text;
    _historyText = _historyText + '\n' + _receivedText;
    emit(MqttReceivedText());
  }
}
