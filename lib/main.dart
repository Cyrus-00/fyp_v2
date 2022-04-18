import 'package:flutter/material.dart';
import 'package:fyp_v2/screens/rfid.dart';
import 'package:fyp_v2/screens/sensor_screen.dart';
import 'package:fyp_v2/constants.dart';
import 'package:fyp_v2/screens/nav_bar.dart';
import 'package:fyp_v2/screens/usage_statistics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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




