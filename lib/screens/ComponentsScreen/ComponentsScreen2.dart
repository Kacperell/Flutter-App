import 'package:flutter/material.dart';
import 'package:app/screens/ComponentsScreen/Component.dart';

class ComponentsScreen2 extends StatefulWidget {
  String _title;
  ComponentsScreen2(this._title);

  @override
  _ComponentsScreen2State createState() => _ComponentsScreen2State();
}

class _ComponentsScreen2State extends State<ComponentsScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Component(),
              Component(),
            ]),
      ),
    );
  }
}
