import 'package:flutter/material.dart';
// import 'screens/home.dart';
import 'package:app/screens/FormWithDateSaving/FormWithDateSaving.dart';
import 'package:app/screens/BSTtime/Bst.dart';

class Home extends StatefulWidget {
  var _screens = [
    FormWithDateSaving('Formularz z zapisem do bazy'),
    Bst('Binarne drzewo poszukiwań - Pomiar czasu'),
    FormWithDateSaving('Formularz z zapisem do bazy'),
  ];

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
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: widget._screens.length,
              padding: EdgeInsets.all(15.0),
              itemBuilder: (BuildContext context, int index) {
                var pages = widget._screens;

                return FlatButton(
                  // color: Colors.blue,
                  // textColor: Colors.white,

                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => pages[index]));
                    // builder: (context) => FormWithDateSaving( 'Formularz  ${widget._xd} z zapisem do bazy')));
                  },

                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${pages[index]}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  // child: Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: Text(
                  //     '${pages[index]}',
                  //     style: TextStyle(fontSize: 18),
                  //   ),
                  // ),
                );
              }),
        ));
  }
}
