import 'package:quizz/core/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  static get databaseHelper => _databaseHelper;

  late Database _dbInstance;

  DatabaseHelper() {
    _initialization();
  }

  Future<void> _initialization() async {
    String path = await getDatabasesPath();
    _dbInstance = await openDatabase(
      join(
        path,
        dbName,
      ),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE quiz (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              age INTEGER NOT NULL, 
              email TEXT NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
  }
}
