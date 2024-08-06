// mqtt_service.dart
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService extends GetxService {
  MqttServerClient? client;
  final RxString receivedMessage = ''.obs;

  Future<void> connect() async {
    client = MqttServerClient.withPort(
        'wss://a7701bd2b3e54353b8aeab74b9c7f322.s1.eu.hivemq.cloud:8884/mqtt',
        'flutter_client',
        8884);
    client?.logging(on: true);
    client?.useWebSocket = true;

    client?.onDisconnected = onDisconnected;
    client?.onConnected = onConnected;

    final connMessage = MqttConnectMessage()
        .authenticateAs('everglo', 'Everglo2024')
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client?.connectionMessage = connMessage;
    client?.websocketProtocols = ['mqtt'];

    try {
      await client?.connect();
    } on Exception catch (e) {
      printError(info: 'EXCEPTION: $e');
      disconnect();
    }
  }

  void disconnect() {
    client?.disconnect();
  }

  void onConnected() {
    printInfo(info: 'Connected');
    client?.subscribe('greenhouse:updated', MqttQos.exactlyOnce);
    client?.subscribe('greenhouseData:created', MqttQos.exactlyOnce);
  }

  void onDisconnected() {
    printInfo(info: 'Disconnected');
  }
}
