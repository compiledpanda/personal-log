import 'package:sqflite/sqflite.dart';

class Wren {
  // Make this a singleton
  Wren._privateConstructor();
  static final Wren instance = Wren._privateConstructor();

  // Expose database via a getter
  late Database _database;
  static Database get database {
    return Wren.instance._database;
  }

  // Init required
  static Future<void> init(String path) async {
    Wren.instance._database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT,
            entry TEXT
          )
        ''');
      },
      version: 1,
    );
  }
}
