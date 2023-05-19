import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? database;
  static Future<bool> createMyDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'abc.db'); // "$databasesPath/demo.db"

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE contactbook (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT, email TEXT)');
        });

    return true;
  }
}
