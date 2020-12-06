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
                        print(notes);
                        return ListView.builder(
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 3.0),
                                          child: Text(
                                            notes[index]['note'],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          notes[index]['selectValue'],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 3.0),
                                          child: Text(
                                            notes[index]['checkboxValue'],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Text(
                                          notes[index]['radioValue'],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
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

class FormNote extends StatefulWidget {
  Function _refresh;
  FormNote(
    this._refresh,
  );

  @override
  _FormNoteState createState() => _FormNoteState();
}

enum SingingCharacter { radio1, radio2 }

class _FormNoteState extends State<FormNote> {
  String selected;

  final myController = TextEditingController();

  String selectvalue;
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  SingingCharacter _radioValue = SingingCharacter.radio1;

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              // hintText: 'Wprowadź notatkę',
              labelText: 'Wprowadź notatkę',
            ),
            controller: myController,
          ),
          DropdownButtonFormField<String>(
            // value: selected,
            // controller: myController,
            decoration: InputDecoration(
              // filled: true,
              labelText: 'Select value',
            ),
            items: ["A", "B", "C"]
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (value) {
              // selectvalue = value;
              setState(() => selectvalue = value);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // [Monday] checkbox
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("check1"),
                  Checkbox(
                    value: check1,
                    onChanged: (bool value) {
                      setState(() {
                        check1 = value;
                      });
                    },
                  ),
                ],
              ),
              // [Tuesday] checkbox
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("check2"),
                  Checkbox(
                    value: check2,
                    onChanged: (bool value) {
                      setState(() {
                        check2 = value;
                      });
                    },
                  ),
                ],
              ),
              // [Wednesday] checkbox
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("check3"),
                  Checkbox(
                    value: check3,
                    onChanged: (bool value) {
                      setState(() {
                        check3 = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text('radio1'),
                leading: Radio(
                  value: SingingCharacter.radio1,
                  groupValue: _radioValue,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _radioValue = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('radio2'),
                leading: Radio(
                  value: SingingCharacter.radio2,
                  groupValue: _radioValue,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _radioValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              //dodaj do bazy

              print(check1);
              print(check2);
              String checkboxValues = '';
              if (check1) checkboxValues = checkboxValues + 'Check 1 ';
              if (check2) checkboxValues = checkboxValues + 'Check 2 ';
              if (check3) checkboxValues = checkboxValues + 'Check 3 ';

              String radioValue = '';
              if (_radioValue == SingingCharacter.radio1) {
                radioValue = 'Radio 1';
              } else {
                radioValue = 'Radio 2';
              }

              print(checkboxValues);
              print(selectvalue);
              print(radioValue);

              if (myController.text == '' || selectvalue == null) {
                //jesli pusta notatka lub nie wybrany select
                print('nope');
                return;
              }

              NotesProvider.insertNote(myController.text, selectvalue,
                  checkboxValues, radioValue); //adding note to sqldb
              myController.text = ''; //clear input

              // notes = NotesProvider.getNotes();
              widget._refresh();
            },
            child: Text('Dodaj notatkę do bazy'),
          )
        ],
      ),
    );
  }
}
