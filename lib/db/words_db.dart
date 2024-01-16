import 'package:aphasia/model/word.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const String _dbName = "words";

  static final _databaseService = DatabaseService._internal();

  factory DatabaseService() => _databaseService;

  DatabaseService._internal();

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
          isFavourite INTEGER NOT NULL,
          image BLOB
        )
      """,
    );

    // inserts a welcome word into the database on first creation
    batch.insert(
        _dbName,
        Word(
          "Benvenuto!",
          isFavourite: true,
          image: (await rootBundle.load("assets/welcome_image.jpg"))
              .buffer
              .asUint8List(),
        ).toMap());

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

  /// Adds the given `word` in the database.
  Future<void> add(Word word) async {
    final db = await _databaseService.getInstance;

    await db.insert(
      _dbName,
      word.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Deletes the given word from the database.
  Future<void> remove(Word word) async {
    final db = await _databaseService.getInstance;

    await db.delete(
      _dbName,
      where: "id = ?",
      whereArgs: [word.getId],
    );
  }

  /// Updates the given `word` with new data.
  Future<void> update(Word word) async {
    final db = await _databaseService.getInstance;

    await db.update(
      _dbName,
      word.toMap(),
      where: "id = ?",
      whereArgs: [word.getId],
    );
  }

  /// Gets all the database entries.
  Future<List<Word>> get getWords async {
    final db = await _databaseService.getInstance;

    final List<Map<String, dynamic>> query = await db.query(_dbName);

    final List<Word> result = List.generate(
      query.length,
      (index) => Word.fromMap(query[index]),
    );

    return result;
  }

  /// Closes this database
  static Future<void> close() async {
    final db = await _databaseService.getInstance;
    await db.close();
  }
}
