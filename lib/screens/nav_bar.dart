import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_v2/screens/remote_control.dart';
import 'package:fyp_v2/screens/rfid.dart';
import 'package:fyp_v2/screens/sensor_screen.dart';
import 'package:fyp_v2/screens/usage_statistics.dart';

// class NavBar extends StatefulWidget {
//   @override
//   _NavBarState createState() => _NavBarState();
// }
//
// class _NavBarState extends State<NavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//
//       length: 2,
//       // initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Menu'),
//           bottom: TabBar(
//             tabs: <Widget>[
//               Tab(
//                 text: 'Remote Control',
//               ),
//               Tab(
//                 text: 'Usage Statistics',
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//
//           children: <Widget>[
//             UsageStatistics(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class NavBar1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/smarthome_cover.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Homepage"),
            onTap: () => navItem(context, 0),
          ),
          ListTile(
            leading: Icon(CommunityMaterialIcons.contactless_payment_circle),
            title: Text("RFID"),
            onTap: () => navItem(context, 1),
          ),
          ListTile(
            leading: Icon(Icons.settings_remote),
            title: Text("Remote Control"),
            onTap: () => navItem(context, 2),
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text("Usage Statistics"),
            onTap: () => navItem(context, 3),
          ),
        ],
      ),
    );
  }
  void navItem(BuildContext context, int index){

    Navigator.of(context).pop();

    switch (index){
      case 0:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => SensorScreen())
        );
        break;
      case 1:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => RFID())
        );
        break;
      case 2:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => RemoteControl())
        );
        break;
      case 3:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => UsageStatistics())
        );
        break;

    }
  }
}
