import 'package:flutter/material.dart';
// import 'screens/home.dart';
import 'package:app/screens/FormWithDateSaving.dart';

class Home extends StatefulWidget {
  String _xd = 'xddd';

  var _screens = [
    FormWithDateSaving('Formularz  z zapisem do bazy'),
    FormWithDateSaving('Formularz  z zapisem do bazy'),
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
          title: const Text('Home8'),
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => pages[index]));
                    // builder: (context) => FormWithDateSaving( 'Formularz  ${widget._xd} z zapisem do bazy')));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      '${pages[index]}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }),
        ));
  }
}

// class _HomeState extends State<Home> {
//   String lol = 'FormWithDateSaving';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           // backgroundColor: Colors.blue[900],
//           title: const Text('Home'),
//           automaticallyImplyLeading: false, //hide back button
//         ),
//         body: Center(
//             child: ListView(
//           children: <Widget>[
//             FlatButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => FormWithDateSaving(
//                           'Formularz ${lol} ${widget._xd} z zapisem do bazy')),
//                 );
//               },
//               child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Text(
//                     'fsafsa',
//                     style: TextStyle(fontSize: 18),
//                   )),
//             ),
//           ],
//         )));
//   }
// }
