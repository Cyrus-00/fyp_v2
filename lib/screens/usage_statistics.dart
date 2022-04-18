import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_v2/screens/nav_bar.dart';
// import 'package:firebase_database/firebase_database.dart';

class UsageStatistics extends StatefulWidget {
  // static const routeName = '/usage-statistics';

  @override
  _UsageStatisticsState createState() => _UsageStatisticsState();
}

class _UsageStatisticsState extends State<UsageStatistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usage Statistics"),
      ),
      drawer: NavBar1(),
    );
  }
}
