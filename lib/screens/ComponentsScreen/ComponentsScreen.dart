import 'package:flutter/material.dart';
import 'package:app/screens/ComponentsScreen/Component.dart';
import 'package:app/screens/ComponentsScreen/ComponentsScreen2.dart';

class ComponentsScreen extends StatefulWidget {
  String _title;
  ComponentsScreen(this._title);
  @override
  _ComponentsScreenState createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
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
              FlatButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ComponentsScreen2('Komponenty ekran drugi')));
                },
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    'Komponenty drugi ekran',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
