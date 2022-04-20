import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'nav_bar.dart';

class RFID extends StatefulWidget {
  const RFID({Key? key}) : super(key: key);

  @override
  State<RFID> createState() => _RFIDState();
}

class _RFIDState extends State<RFID> with AutomaticKeepAliveClientMixin{

  void iniState(){
    super.initState();
  }
  final notifications = {
    CheckBoxState(title: "Light"),
    CheckBoxState(title: "Fan"),
  };

  late UniqueKey keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RFID"),
        ),
        drawer: NavBar1(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildCard(
                title: 'RFID Card 1',
                imagePath: 'assets/images/RFID_card.jpg',
                scale: 15,
                onTap: () => isExpanded ? shrinkTile() : expandTile(),
              ),

              buildCard(
                title: 'RFID Card 2',
                imagePath: 'assets/images/RFID_keychain.jpg',
                scale: 5,
                onTap: () => isExpanded ? shrinkTile() : expandTile(),
              ),
            ],
          ),
        )
    );
  }

  Widget buildCard(
      {required String title,
        required String imagePath,
        required double scale,
        VoidCallback? onTap}) {
    super.build(context);
    return ExpandableNotifier(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Image.asset(imagePath,
                  scale: scale,),
              ),
              ScrollOnExpand(
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                    expandIcon: Icons.keyboard_arrow_down,
                    collapseIcon: Icons.keyboard_arrow_up,
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  collapsed: Text(
                    "Show Controllable Appliances",
                    style: TextStyle(fontSize: 18),),
                  expanded:
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(12),
                    children: [
                      ...notifications.map(buildCheckBox).toList(),
                    ],
                  ),
                  builder: (_, collapsed, expanded) =>
                      Padding(
                        padding: const EdgeInsets.all(10.0).copyWith(top: 0),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget buildCheckBox(CheckBoxState checkbox) =>
      CheckboxListTile(
          value: checkbox.value,
          title: Text(
            checkbox.title,
            style: TextStyle(fontSize: 20),
          ),
          onChanged: (value) => setState(() => checkbox.value = value!)
      );

  @override
  bool get wantKeepAlive => true;

}

class CheckBoxState{
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}
