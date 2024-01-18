import 'package:aphasia/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabaseService {
  static const String _dbName = "user";

  static final _databaseService = UserDatabaseService._internal();

  factory UserDatabaseService() => _databaseService;

  UserDatabaseService._internal();

  /// the reference to the database
  static Database? _database;

  /// Initializes the database with the tables used to store the words data.
  Future<void> _init(Database db) async {
    final batch = db.batch();
    // the content of a word is unique!
    // here it's used as a primary key
    batch.execute(
      """
        CREATE TABLE $_dbName(
          id TEXT PRIMARY KEY NOT NULL,
          name TEXT NOT NULL, 
          image BLOB
        )
      """,
    );

    // inserts a welcome word into the database on first creation
    batch.insert(_dbName, User(name: "Utente").toMap());

    await batch.commit();
  }

  /// gets the instance of the opened database
  Future<Database> get getInstance async {
    if (_database != null) return _database!;

    // opens a new database in the given path
    _database = await openDatabase(
      // gets the path of the database
      join(await getDatabasesPath(), "$_dbName.db"),
      // creates the tables of the database if it's opened for the first time
      onCreate: (db, version) => _init(db),
      version: 1,
    );

    return _database!;
  }

  /// Updates the given `word` with new data.
  Future<void> update(User user) async {
    final db = await _databaseService.getInstance;

    await db.update(
      _dbName,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  /// Gets all the database entries.
  Future<User> get getUser async {
    final db = await _databaseService.getInstance;

    final query = await db.query(_dbName);
    return User.fromMap(query.first);
  }

  /// Closes this database
  static Future<void> close() async {
    final db = await _databaseService.getInstance;
    await db.close();
  }
}
