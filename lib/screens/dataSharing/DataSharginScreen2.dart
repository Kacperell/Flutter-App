import 'package:flutter/material.dart';

class DataSharginScreen2 extends StatefulWidget {
  String _title;
  String _number;
  DataSharginScreen2(this._number);

  @override
  _DataSharginScreen2State createState() => _DataSharginScreen2State();
}

class _DataSharginScreen2State extends State<DataSharginScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wspołdzielanie danych'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Przekazana: ${widget._number}'),
            ]),
      ),
    );
  }
}
