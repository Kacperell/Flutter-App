import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String table = 'Notes';
final String columnId = '_id';
final String columnTitle = 'note';

class NotesProvider {
  static Database db;

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        version: 1, onCreate: (db, version) async {
      print("create dbbb!");

      await db.execute('''
        create table $table ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          selectValue text,
          checkboxValue text,
          radioValue text 
          )
        ''');

      db.insert('$table', {
        '$columnTitle': 'Example',
        'selectValue': 'C',
        'checkboxValue': 'check1',
        'radioValue': 'radio2',
      });
    });
  }

  static Future insertNote(
      noteText, noteSelect, noteCheckbox, noteRadio) async {
    // await db.insert('Notes', word);

    // db.insert('$table', {'$columnTitle': noteText});

    db.insert('$table', {
      '$columnTitle': noteText,
      'selectValue': noteSelect,
      'checkboxValue': noteCheckbox,
      'radioValue': noteRadio,
    });
  }

  static Future getNotes() async {
    if (db == null) {
      await open();
    }
    var notes = await db.rawQuery('SELECT * FROM "Notes"');
    print('-----DBNOTES---------');

    return await db.rawQuery('SELECT * FROM "Notes"');
  }

  Future close() async => db.close();
}
