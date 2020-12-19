import 'package:flutter/material.dart';

class Component extends StatelessWidget {
  const Component({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Text('Komponent'),
                ),
                Image.asset('assets/imgexample.jpg'),
              ]),
        ),
      ),
    );
  }
}
