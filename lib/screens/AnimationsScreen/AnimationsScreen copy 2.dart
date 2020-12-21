import 'package:flutter/material.dart';
import 'dart:math';

class AnimationsScreen extends StatefulWidget {
  String _title;
  AnimationsScreen(this._title);

  @override
  _AnimationsScreenState createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller);

    _controller.forward();
    _controller.addListener(() {
      setState(() {});

      // print(_controller.value);
      print(_colorAnimation.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer Demo'),
        ),
        body: Column(
          children: [
            Text('fsa'),
            Center(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                // color: Colors.amber[600],
                color: _colorAnimation.value,
                width: 48.0,
                height: 48.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
