import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Alert extends StatefulWidget {
  String _title;
  Alert(this._title);

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  void showAlert() {
    Fluttertoast.showToast(
        msg: "Przykładowy alert",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }

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
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text('Wyświetl alert'), onPressed: showAlert),
              ),
            ]),
      ),
    );
  }
}
