import 'package:flutter/material.dart';
// import 'screens/home.dart';
import 'package:app/screens/FormWithDateSaving/FormWithDateSaving.dart';
import 'package:app/screens/BSTtime/Bst.dart';
import 'package:app/screens/Camera/Camera.dart';
import 'package:app/screens/GPS/GPS.dart';
import 'package:app/screens/Accelerometer/Accelerometer.dart';
import 'package:app/screens/AudioRecorder/AudioRecorder.dart';
import 'package:app/screens/VideoYT/VideoYT.dart';
import 'package:app/screens/ListViewScreen/ListViewScreen.dart';
import 'package:app/screens/ComponentsScreen/ComponentsScreen.dart';
import 'package:app/screens/AnimationsScreen/AnimationsScreen.dart';
import 'package:app/screens/Modal/Modal.dart';
import 'package:app/screens/Alert/Alert.dart';
import 'package:app/screens/DataSharing/DataSharginScreen.dart';

class Home extends StatefulWidget {
  List _screens = [
    [
      FormWithDateSaving('Formularz z zapisem do bazy'),
      'Formularz z zapisem do bazy'
    ],
    [
      Bst('Binarne drzewo poszukiwań - Pomiar czasu'),
      'Binarne drzewo poszukiwań - Pomiar czasu'
    ],
    [Camera('Dostęp do aparatu'), 'Dostęp do aparatu'],
    [GPS('Lokalizacja na mapie'), 'Lokalizacja na mapie'],
    [Accelerometer('Akcelerometr i żyroskop'), 'Akcelerometr i żyroskop'],
    [AudioRecorder('Nagranie dźwieku'), 'Nagranie dźwieku'],
    [VideoYT('Obsługa multimediów'), 'Obsługa multimediów'],
    [ListViewScreen('Dynamiczna lista'), 'Dynamiczna lista'],
    [AnimationsScreen('Animacje'), 'Animacje'],
    [ComponentsScreen('Komponenty'), 'Komponenty'],
    [Modal('Modal'), 'Modal'],
    [Alert('Alert'), 'Alert'],
    [DataSharginScreen('Wspóldzielanie danych'), 'Wspóldzielanie danych'],
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget._screens.length,
            padding: EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int index) {
              var pages = widget._screens;
              return FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pages[index][0]));
                },
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      '${pages[index][1]}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
