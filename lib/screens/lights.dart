import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_v2/constants.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class Lights extends StatefulWidget {
  const Lights({Key? key}) : super(key: key);

  @override
  _LightsState createState() => _LightsState();
}

class _LightsState extends State<Lights> {
  bool lightState = true;

  final dbR = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
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
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: size.height * 0.025),
                      lightState
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
                              onPressed: () {
                                dbR.child("Lights").set({"Status": !lightState});
                                setState(() {
                                  lightState = !lightState;
                                });
                              },
                              splashColor: Colors.grey,
                              hoverColor: Colors.grey,
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
