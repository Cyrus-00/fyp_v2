import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'nav_bar.dart';

class RFID extends StatefulWidget {
  const RFID({Key? key}) : super(key: key);

  @override
  State<RFID> createState() => _RFIDState();
}

class _RFIDState extends State<RFID> {

  final notifications = {
    CheckBoxState(title: "Light"),
    CheckBoxState(title: "Fan"),
  };

  late ExpandableController controller;

  @override
  void initState(){
    super.initState();

    controller = ExpandableController();
  }

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RFID"),
      ),
      drawer: NavBar1(),
      body: Row(
        children: [
          buildCard(
            'RFID Card 1',
            'assets/images/RFID_card.jpg'
          ),
        ],
      ),
    );
  }
  Widget buildCard(String title, String imagePath) => ExpandableNotifier(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => controller.toggle(),
              child: Image.asset(imagePath),
            ),
            ExpandablePanel(
              controller: controller,
              theme: ExpandableThemeData(
                expandIcon: Icons.keyboard_arrow_down,
                collapseIcon: Icons.keyboard_arrow_up,
                tapHeaderToExpand: true,
                tapBodyToCollapse: true,
              ),
              header: Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              collapsed: Text("Show Controllable Appliances"),
              expanded: ListView(
                padding: EdgeInsets.all(12),
                children: [
                  ...notifications.map(buildCheckBox).toList(),
                ],

              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildCheckBox(CheckBoxState checkbox) => CheckboxListTile(
      value: checkbox.value,
      title: Text(
        checkbox.title,
        style: TextStyle(fontSize: 20),
      ),
      onChanged: (value) => setState(() => checkbox.value = value!)
  );

}

class CheckBoxState{
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}
