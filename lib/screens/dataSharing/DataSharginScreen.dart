import 'package:flutter/material.dart';
import 'package:app/screens/DataSharing/DataSharginScreen2.dart';

class DataSharginScreen extends StatefulWidget {
  String _title;
  DataSharginScreen(this._title);

  @override
  _DataSharginScreenState createState() => _DataSharginScreenState();
}

class _DataSharginScreenState extends State<DataSharginScreen> {
  int _counter = 7;
  void _icremnet() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
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
              Text('Liczba : ${_counter}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 130,
                      child: RaisedButton.icon(
                        onPressed: () {
                          _decrement();
                        },
                        icon: Icon(Icons.remove),
                        label: Text('Odejmij'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 130,
                      child: RaisedButton.icon(
                        onPressed: () {
                          _icremnet();
                        },
                        icon: Icon(Icons.add),
                        label: Text('Dodaj'),
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DataSharginScreen2('${_counter}')));
                },
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    'Drugi ekran z przekazną liczbą',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
