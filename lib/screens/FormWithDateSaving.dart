import 'package:flutter/material.dart';
import 'package:app/screens/home.dart';

class FormWithDateSaving extends StatefulWidget {
  String _title;
  FormWithDateSaving(this._title);
  @override
  _FormWithDateSavingState createState() => _FormWithDateSavingState();
}

class _FormWithDateSavingState extends State<FormWithDateSaving> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );

        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.blue[900],
            title: Text(widget._title),
          ),
          body: Center(child: Text(widget._title))),
    );
  }
}
