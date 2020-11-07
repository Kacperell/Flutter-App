import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blue[900],
          title: const Text('Home'),
          automaticallyImplyLeading: false, //hide back button
        ),
        body: Center(child: Text('home')));
  }
}
