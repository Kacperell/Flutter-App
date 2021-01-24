import 'package:flutter/material.dart';

class Modal extends StatefulWidget {
  String _title;
  Modal(this._title);

  @override
  _ModalState createState() {
    print('createState');
    return _ModalState();
  }

}

class _ModalState extends State<Modal> {
  @override
  initState() {
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print("build ");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Modal'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Modal"),
                          content: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "),
                        );
                      });
                },
              ),
            ]),
      ),
    );
  }
}
