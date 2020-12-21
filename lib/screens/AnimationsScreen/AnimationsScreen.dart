import 'package:flutter/material.dart';
import 'dart:math';

class AnimationsScreen extends StatefulWidget {
  String _title;
  AnimationsScreen(this._title);

  @override
  _AnimationsScreenState createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _rotationController;

  Animation _opacityAnimation;
  Animation _transformAnimation;
  Animation _textAnimation;
  Animation _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _transformAnimation = Tween(begin: -100.0, end: 100.0).animate(_controller);
    _textAnimation = Tween(begin: 20.0, end: 40.0).animate(_controller);

    _rotationAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
    _rotationController.repeat();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, _) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    color:
                        Colors.blue[600].withOpacity(_opacityAnimation.value),
                    width: 48.0,
                    height: 48.0,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
            child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, _) {
                  return Transform.translate(
                    offset: Offset(_transformAnimation.value, 0.0),
                    child: Container(
                        width: 48.0, height: 48.0, color: Colors.yellow[600]),
                  );
                  // )
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
            child: AnimatedBuilder(
                animation: _rotationController,
                builder: (BuildContext context, _) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(
                      _rotationAnimation.value * 2 * 3.14,
                    ),
                    child: Container(
                        width: 48.0, height: 48.0, color: Colors.green[600]),
                  );
                  // )
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, _) {
                return Center(
                    child: Text(
                  "Tekst",
                  style: TextStyle(
                    fontSize: _textAnimation.value,
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
