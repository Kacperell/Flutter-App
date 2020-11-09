import 'package:flutter/material.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/FormWithDateSaving/NotesProvider.dart';
import 'package:sqflite/sqflite.dart';

class FormWithDateSaving extends StatefulWidget {
  String _title;
  FormWithDateSaving(this._title);
  @override
  _FormWithDateSavingState createState() => _FormWithDateSavingState();
}

var notes = NotesProvider.getNotes();

class _FormWithDateSavingState extends State<FormWithDateSaving> {
  Function refresh() {
    //refresh widget after add note to db
    setState(() => print("refresh"));
  }

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
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormNote(refresh),
              ),
              Container(
                margin: const EdgeInsets.only(left: 80.0, right: 80.0),
                child: FutureBuilder(
                    // future: notes,
                    future: NotesProvider.getNotes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final notes = snapshot.data;
                        print('-----notes---------');
                        print(notes);
                        return ListView.builder(
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(
                                  notes[index]['note'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                Divider(),
                              ],
                            );
                          },
                          itemCount: notes.length,
                        );
                      } else {
                        //jesli jeszcze nie wczytano danych
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}

class FormNote extends StatelessWidget {
  Function _refresh;
  FormNote(
    this._refresh,
  );

  final myController = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Wprowadź notatkę'),
            controller: myController,
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              //dodaj do bazy
              if (myController.text == '') {
                //jesli pusta notatka
                return;
              }
              NotesProvider.insertNote(
                  myController.text); //adding note to sqldb
              myController.text = ''; //clear input

              // notes = NotesProvider.getNotes();
              _refresh();
            },
            child: Text('Dodaj notatkę do bazy'),
          )
        ],
      ),
    );
  }
}
