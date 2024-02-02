import 'package:aphasia/model/event.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EventsDatabaseService {
  static const String _dbName = "events";

  static final _databaseService = EventsDatabaseService._();
  factory EventsDatabaseService() => _databaseService;

  EventsDatabaseService._();

  static Database? _database;

  Future<void> _init(Database db) async {
    await db.execute(
      """
        CREATE TABLE $_dbName(
          id TEXT PRIMARY KEY NOT NULL,
          title TEXT NOT NULL,
          date INTEGER NOT NULL
        )
      """,
    );
  }

  Future<Database> get getInstance async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), "$_dbName.db"),
      onCreate: (db, version) => _init(db),
      version: 1,
    );

    return _database!;
  }

  Future<void> add(Event event) async {
    final db = await _databaseService.getInstance;

    await db.insert(
      _dbName,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> remove(Event event) async {
    final db = await _databaseService.getInstance;

    await db.delete(
      _dbName,
      where: "id = ?",
      whereArgs: [event.id],
    );
  }

  Future<List<Event>> get getEvents async {
    final db = await _databaseService.getInstance;
    final now = DateTime.now().millisecondsSinceEpoch;

    // removes all the past events
    await db.delete(
      _dbName,
      where: "date < ?",
      whereArgs: [now],
    );

    // retrieves all the saved events
    final List<Map<String, dynamic>> query = await db.query(_dbName);

    return List.generate(
      query.length,
      (index) => Event.fromMap(query[index]),
    );
  }

  static Future<void> close() async {
    final db = await _databaseService.getInstance;
    await db.close();
  }
}
