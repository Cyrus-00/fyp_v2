import 'package:flutter/material.dart';
import 'nav_bar.dart';

class RemoteControl extends StatelessWidget {
  const RemoteControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remote Control"),
      ),
      drawer: NavBar1(),
    );
  }
}
