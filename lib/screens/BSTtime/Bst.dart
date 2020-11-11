import 'package:flutter/material.dart';
import 'dart:math';

class Node {
  Node(this.val);
  int val;
  Node left;
  Node right;
  int count = 0;
}

class BST {
  var root;
  BST() {
    root = null;
  }

  add(val) {
    Node newNode = Node(val);
    if (root == null) {
      root = newNode;
      return this;
    }
    var current = root;

    addSide(side) {
      if (side == 'right') {
        if (current.right == null) {
          current.right = newNode;
          return this;
        }
        current = current.right;
      } else {
        if (current.left == null) {
          current.left = newNode;
          return this;
        }
        current = current.left;
      }
    }

    while (true) {
      if (val == current.val) {
        current.count++;
        return this;
      }
      if (val < current.val) {
        addSide('left');
      } else {
        addSide('right');
      }
    }
  }
}

int numbersToBst = 1000000;

class Bst extends StatefulWidget {
  String _title;
  Bst(this._title);
  @override
  _BstState createState() => _BstState();
}

class _BstState extends State<Bst> {
  String time = 'Czas wykonania:';

  void startBst() {
    BST tree = BST();

    var rng = new Random();

    final stopwatch = Stopwatch()..start();

    print('stopwatch ${stopwatch}');

    for (int i = 0; i < numbersToBst; i++) {
      tree.add(rng.nextInt(numbersToBst));
    }

    setState(() {
      time = 'Czas wykonania: ${stopwatch.elapsed}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue[900],
        title: Text(widget._title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                      'Dodaj ${numbersToBst} liczb do binarnego drzewa przeszukiwań.')),
              Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Text(time)),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                onPressed: () {
                  startBst();
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Start'),
                ),
              ),
            ]),
      ),
    );
  }
}
