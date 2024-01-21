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

  /// Initializes the database with the tables used to store the user data.
  Future<void> _init(Database db) async {
    await db.execute(
      """
        CREATE TABLE $_dbName(
          id TEXT PRIMARY KEY NOT NULL,
          name TEXT NOT NULL
        )
      """,
    );
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

  /// Adds the given `user` to the database.
  ///
  /// Can be called once. All future calls will be ignored.
  Future<void> add(User user) async {
    if (await getUser != null) return;

    final db = await _databaseService.getInstance;
    await db.insert(
      _dbName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Updates the given `user` with new data.
  Future<void> update(User user) async {
    final db = await _databaseService.getInstance;

    await db.update(
      _dbName,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  /// Gets the user from the database.
  Future<User?> get getUser async {
    final db = await _databaseService.getInstance;

    final query = await db.query(_dbName);

    // if no user has been found, return null
    if (query.isEmpty) return null;
    // else create a new instance of the user.
    return User.fromMap(query.first);
  }

  /// Closes this database.
  static Future<void> close() async {
    final db = await _databaseService.getInstance;
    await db.close();
  }
}
