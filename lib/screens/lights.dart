import 'dart:ffi';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_v2/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

// FirebaseDatabase database = FirebaseDatabase.instance;

class Lights extends StatefulWidget {
  const Lights({Key? key}) : super(key: key);

  @override
  _LightsState createState() => _LightsState();

}

class _LightsState extends State<Lights>{
  // String broker           = 'broker.hivemq.com';
  // int port                = 1883;
  // String clientIdentifier = 'FYPv2';
  //
  // String username         = 'public';
  // String passwd           = 'public';
  //
  // bool _lightState = false;
  //
  // late mqtt.MqttClient client;
  // late mqtt.MqttConnectionState connectionState;
  // late StreamSubscription subscription;
  //
  // void _subscribeToTopic(String topic) {
  //   if (connectionState == mqtt.MqttConnectionState.connected) {
  //     print('[MQTT client] Subscribing to ${topic.trim()}');
  //     client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
  //   }
  // }
  late final dbR = FirebaseDatabase.instance.ref("Lights");
  late DatabaseReference databaseReference;

  late Future<bool> lightState = getData();


  getCurrentDate(){
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  getCurrentTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var time = DateTime.now();

    // convert to GMT+8 time and check whether hour surpass 24:00
    int hour = (time.hour + 8) > 24 ? (time.hour + 8 - 24):(time.hour + 8);
    String Time = "${hour}:${time.minute}:${time.second}";

    //save to shared preferences
    prefs.setInt("Start", ((DateTime.now().microsecondsSinceEpoch)/1000000).toInt());

    return Time;
  }

  getElapsedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dt = DateTime.now();

    SharedPreferences.getInstance().then((data){
      data.getKeys().forEach((key){
        print(key+"="+ (data.get(key)).toString());
        int start = int.parse(data.get(key).toString());

      int time = ((DateTime.now().microsecondsSinceEpoch)/1000000).toInt();

      dbR.child((dt.year).toString()).
      child((dt.month).toString()).
      child((dt.day).toString()).
      child(getCurrentTime()).
      update({"Elapsed Time": time-start});

      });
      // int start = prefs.getInt("Start") ?? 0;
    });


  }

  Future<bool> getData() async {
    return dbR.once().then((snapshot){
      print((snapshot.snapshot.value as Map)["Status"]);
      return (snapshot.snapshot.value as Map)["Status"];
    });
  }

  void initState(){
    super.initState();
    databaseReference = dbR;
  }


  @override
  Widget build(BuildContext context) {

    var dt = DateTime.now();

    Size size = MediaQuery.of(context).size;



    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kBgColor,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: FirebaseAnimatedList(query: dbR,
                    itemBuilder: (BuildContext context,
                        DataSnapshot snapshot,
                        Animation<double> animation,
                        int index
                        ){
                      var state = snapshot.value;
                      bool light = state.toString() == "true";

                      // print(state.runtimeType);
                      // var light = state["Status"];
                      return
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.025),
                            light
                            ? Icon(
                                  Icons.lightbulb,
                                  size: 200,
                                  color: Colors.amber.shade400,
                                )
                              : Icon(
                                  Icons.lightbulb_outline_rounded,
                                  size: 200,
                                  color: Colors.white,
                                ),
                            SizedBox(height: size.height * 0.025),
                            const Center(
                              child: Text(
                                'Lights',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: TabBar(
                                  indicator: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                      colors: [Colors.blue, Colors.lightBlueAccent],
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: [
                                    Tab(
                                      text: "Manual",
                                    ),
                                    Tab(text: "Smart")
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: TabBarView(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.power_settings_new_rounded,
                                      color: Colors.blueGrey
                                    ),
                                    iconSize: 64,
                                    onPressed: () async {
                                      dbR.set({"Status": !light});
                                      //if on, save current time, if off
                                      print(light);

                                      // light
                                      // ? getElapsedTime():
                                      dbR.child((dt.year).toString()).
                                        child((dt.month).toString()).
                                        child((dt.day).toString()).
                                        child(getCurrentTime()).
                                        set({"Elapsed Time": 0});
                                      setState(() {
                                        light = !light;
                                      });
                                    },
                                      splashColor: Colors.grey,
                                      hoverColor: Colors.grey,
                                    ),
                                    Container(),
                                ],
                              )
                            )
                          ]
                        );
                    }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // void _connect() async {
  //   /// First create a client, the client is constructed with a broker name, client identifier
  //   /// and port if needed. The client identifier (short ClientId) is an identifier of each MQTT
  //   /// client connecting to a MQTT broker. As the word identifier already suggests, it should be unique per broker.
  //   /// The broker uses it for identifying the client and the current state of the client. If you don’t need a state
  //   /// to be hold by the broker, in MQTT 3.1.1 you can set an empty ClientId, which results in a connection without any state.
  //   /// A condition is that clean session connect flag is true, otherwise the connection will be rejected.
  //   /// The client identifier can be a maximum length of 23 characters. If a port is not specified the standard port
  //   /// of 1883 is used.
  //   /// If you want to use websockets rather than TCP see below.
  //   ///
  //   client = mqtt.MqttClient(broker, '');
  //   client.port = port;
  //
  //   /// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
  //   /// for details.
  //   /// To use websockets add the following lines -:
  //   /// client.useWebSocket = true;
  //   /// client.port = 80;  ( or whatever your WS port is)
  //   /// Note do not set the secure flag if you are using wss, the secure flags is for TCP sockets only.
  //   /// Set logging on if needed, defaults to off
  //   client.logging(on: true);
  //
  //   /// If you intend to use a keep alive value in your connect message that is not the default(60s)
  //   /// you must set it here
  //   client.keepAlivePeriod = 30;
  //
  //   /// Add the unsolicited disconnection callback
  //   client.onDisconnected = _onDisconnected;
  //
  //   /// Create a connection message to use or use the default one. The default one sets the
  //   /// client identifier, any supplied username/password, the default keepalive interval(60s)
  //   /// and clean session, an example of a specific one below.
  //   final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
  //       .withClientIdentifier(clientIdentifier)
  //       .startClean() // Non persistent session for testing
  //       .keepAliveFor(30)
  //       .withWillQos(mqtt.MqttQos.atMostOnce);
  //   print('[MQTT client] MQTT client connecting....');
  //   client.connectionMessage = connMess;
  //
  //   /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
  //   /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
  //   /// never send malformed messages.
  //   try {
  //     await client.connect(username, passwd);
  //   } catch (e) {
  //     print(e);
  //     _disconnect();
  //   }
  //
  //   /// Check if we are connected
  //   if (client.connectionState == mqtt.MqttConnectionState.connected) {
  //     print('[MQTT client] connected');
  //     setState(() {
  //       connectionState = client.connectionState;
  //     });
  //   } else {
  //     print('[MQTT client] ERROR: MQTT client connection failed - '
  //         'disconnecting, state is ${client.connectionState}');
  //     _disconnect();
  //   }
  //
  //   /// The client has a change notifier object(see the Observable class) which we then listen to to get
  //   /// notifications of published updates to each subscribed topic.
  //   subscription = client.updates.listen(_onMessage);
  //
  //   _subscribeToTopic("/lightbulb/status");
  // }
  //
  // void _disconnect() {
  //   print('[MQTT client] _disconnect()');
  //   client.disconnect();
  //   _onDisconnected();
  // }
  //
  // void _onDisconnected() {
  //   print('[MQTT client] _onDisconnected');
  //   setState(() {
  //     //topics.clear();
  //     connectionState = client.connectionState;
  //     subscription.cancel();
  //   });
  //   print('[MQTT client] MQTT client disconnected');
  // }
  //
  // void _onMessage(List<mqtt.MqttReceivedMessage> event) {
  //   print(event.length);
  //   final mqtt.MqttPublishMessage recMess =
  //   event[0].payload as mqtt.MqttPublishMessage;
  //   final String message =
  //   mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //
  //   /// The above may seem a little convoluted for users only interested in the
  //   /// payload, some users however may be interested in the received publish message,
  //   /// lets not constrain ourselves yet until the package has been in the wild
  //   /// for a while.
  //   /// The payload is a byte buffer, this will be specific to the topic
  //   print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
  //       'payload is <-- ${message} -->');
  //   print(client.connectionState);
  //   print("[MQTT client] message with topic: ${event[0].topic}");
  //   print("[MQTT client] message with message: ${message}");
  //   setState(() {
  //     _lightState = message.toLowerCase() != "false";
  //   });
  // }
}


