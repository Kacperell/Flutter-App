import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String table = 'Notes';
final String columnId = '_id';
final String columnTitle = 'note';

// final String tableTodo = 'todo';

class NotesProvider {
  static Database db;

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        version: 1, onCreate: (db, version) async {
      print("create dbbb!");

      // db.execute('''
      //     create table Notes(
      //       id integer primary key autoincrement,
      //       note text ,
      //     );
      //            ''');

      await db.execute('''
        create table $table ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null)
        ''');

      db.insert('$table', {'$columnTitle': 'Example'});

      // var todo = {columnTitle: 'xdd'};
      // await db.insert(table, todo);
    });
  }

  static Future insertNote(note) async {
    // await db.insert('Notes', word);
    db.insert('$table', {'$columnTitle': note});
  }

  static Future getNotes() async {
    if (db == null) {
      await open();
    }
    var notes = await db.rawQuery('SELECT * FROM "Notes"');
    print('-----DBNOTES---------');
    print(notes);
    // return await notes;
    return await db.rawQuery('SELECT * FROM "Notes"');
    // List<Map> notes = await db.query(
    //   table,
    //   columns: [columnId, columnTitle],
    // );
    // return notes;
  }

  Future close() async => db.close();
}
