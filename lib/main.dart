import 'package:flutter/material.dart';
import 'package:fyp_v2/screens/rfid.dart';
import 'package:fyp_v2/screens/sensor_screen.dart';
import 'package:fyp_v2/screens/usage_statistics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final client = MqttServerClient('broker.hivemq.com', '');

var pongCount = 0; // Pong counter

Future <void> main() async {

  // /// Set logging on if needed, defaults to off
  // client.logging(on: true);
  //
  // /// Set the correct MQTT protocol for mosquito
  // client.setProtocolV311();
  //
  // /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
  // client.keepAlivePeriod = 30;
  //
  // /// Add the unsolicited disconnection callback
  // // client.onDisconnected = onDisconnected;
  //
  // /// Add the successful connection callback
  // client.onConnected = onConnected;
  //
  // /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
  // /// You can add these before connection or change them dynamically after connection if
  // /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
  // /// can fail either because you have tried to subscribe to an invalid topic or the broker
  // /// rejects the subscribe request.
  // // client.onSubscribed = onSubscribed;
  //
  // /// Set a ping received callback if needed, called whenever a ping response(pong) is received
  // /// from the broker.
  // client.pongCallback = pong;
  //
  // /// Create a connection message to use or use the default one. The default one sets the
  // /// client identifier, any supplied username/password and clean session,
  // /// an example of a specific one below.
  // final connMess = MqttConnectMessage()
  //     .withClientIdentifier('FYP')
  //     .startClean() // Non persistent session for testing
  //     .withWillQos(MqttQos.atLeastOnce);
  // print('EXAMPLE::Mosquitto client connecting....');
  // client.connectionMessage = connMess;
  //
  // /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
  // /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
  // /// never send malformed messages.
  // try {
  //   await client.connect();
  // } on NoConnectionException catch (e) {
  //   // Raised by the client when connection fails.
  //   print('EXAMPLE::client exception - $e');
  //   client.disconnect();
  // } on SocketException catch (e) {
  //   // Raised by the socket layer
  //   print('EXAMPLE::socket exception - $e');
  //   client.disconnect();
  // }
  //
  // if (client.connectionStatus!.state == MqttConnectionState.connected) {
  //   print('EXAMPLE::Mosquitto client connected');
  // }
  // else{
  //   client.doAutoReconnect(force: true);
  // }
  //
  // /// Lets publish to our topic
  // /// Use the payload builder rather than a raw buffer
  // /// Our known topic to publish to
  // const pubTopic = 'Lights/Status';
  // final builder = MqttClientPayloadBuilder();
  // builder.addBool(val: true);
  //
  // /// Publish it
  // print('EXAMPLE::Publishing our topic');
  // client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);


  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/// The successful connect callback
void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was successful');
}

/// Pong callback
void pong() {
  print('EXAMPLE::Ping response client callback invoked');
  pongCount++;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Home",
      theme: ThemeData(
        // primarySwatch: Colors.lightBlue
        fontFamily: "Poppins",
      ),
      home: SensorScreen(),
      routes: {
        '/rfid': (context) => RFID(),
        '/usage-statistics': (context) => UsageStatistics(),
      },

    );
  }
}




