import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'data.db');
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE data(id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT)',
      );
    });
  }

  Future<void> insertData(String value) async {
    final db = await database;
    await db.insert(
      'data',
      {'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final db = await database;
    return await db.query('data');
  }
}

