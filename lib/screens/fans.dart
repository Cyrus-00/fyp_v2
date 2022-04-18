import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_v2/constants.dart';
import 'package:fyp_v2/custom_icon_icons.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class Fans extends StatefulWidget {
  const Fans({Key? key}) : super(key: key);

  @override
  _FansState createState() => _FansState();
}

class _FansState extends State<Fans> {
  
  bool fanState = true;
  double fanSpeed = 0;
  double turnOnTemp = 20;
  double turnOffTemp = 15;

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
                      fanState
                          ? Icon(
                        CommunityMaterialIcons.fan,
                        size: 200,
                        color: Colors.black87,
                      )
                          : Icon(
                        CommunityMaterialIcons.fan_off,
                        size: 200,
                        color: Colors.black87,
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
                            // Manual
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: size.height * 0.025),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 24),
                                          child: Text(
                                            'Fan Speed',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Slider(
                                          value: fanSpeed,
                                          min: 0,
                                          max: 3,
                                          divisions: 2,
                                          onChanged: (value) {
                                            setState(() => fanSpeed = value);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text('Low'),
                                              Text('Mid'),
                                              Text('High'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.025),
                                  Center(
                                    child: IconButton(
                                      icon: Icon(
                                          Icons.power_settings_new_rounded,
                                          color: Colors.blueGrey
                                      ),
                                      iconSize: 100,
                                      onPressed: () {
                                        dbR.child("Fan").set({"Status": !fanState});
                                        setState(() {
                                          fanState = !fanState;
                                        });
                                      },
                                      splashColor: Colors.grey,
                                      hoverColor: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Smart
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: size.height * 0.025),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 24),
                                          child: Text(
                                            'Turn On Temp',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Slider(
                                          value: turnOnTemp,
                                          min: 10,
                                          max: 40,
                                          divisions: 30,
                                          label: turnOnTemp.toString(),
                                          onChanged: (value) {
                                            setState(() => turnOnTemp = value);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                            Text('10\u00B0'),
                                            Text('15\u00B0'),
                                            Text('20\u00B0'),
                                            Text('25\u00B0'),
                                            Text('30\u00B0'),
                                            Text('35\u00B0'),
                                            Text('40\u00B0'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.025),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 24),
                                          child: Text(
                                            'Turn Off Temp',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Slider(
                                          value: turnOffTemp,
                                          min: 10,
                                          max: 40,
                                          divisions: 30,
                                          label: turnOffTemp.toString(),
                                          onChanged: (value) {
                                            setState(() => turnOffTemp = value);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text('10\u00B0'),
                                              Text('15\u00B0'),
                                              Text('20\u00B0'),
                                              Text('25\u00B0'),
                                              Text('30\u00B0'),
                                              Text('35\u00B0'),
                                              Text('40\u00B0'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      )
    );
  }
}
