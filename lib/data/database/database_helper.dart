
import 'package:altur/constants/app_constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.localDbName);

    return await openDatabase(
      path,
      version: 4, 
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TBL_VEHICLES(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        brand TEXT,
        model TEXT,
        licensePlate TEXT,
        currentMileage INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE TBL_MAINTENANCE(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        date TEXT,
        cost REAL,
        mileage INTEGER,
        vehicleId INTEGER,
        FOREIGN KEY (vehicleId) REFERENCES TBL_VEHICLES (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE TBL_NOTIFICATION(
        maintenance_record_id INTEGER PRIMARY KEY,
        notification_date TEXT,
        actual_maintenance_date TEXT,
        FOREIGN KEY (maintenance_record_id) REFERENCES TBL_MAINTENANCE (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
       await db.execute('DROP TABLE IF EXISTS TBL_NOTIFICATION');
      await db.execute('''
        CREATE TABLE TBL_NOTIFICATION(
          maintenance_record_id INTEGER PRIMARY KEY,
          notification_date TEXT,
          actual_maintenance_date TEXT,
          FOREIGN KEY (maintenance_record_id) REFERENCES TBL_MAINTENANCE (id) ON DELETE CASCADE
        )
      ''');
    }
  }

    Future<void> removeExpiredNotifications() async {
    final db = await database;
    final now = DateTime.now().toIso8601String();

    await db.delete(
      'TBL_NOTIFICATION',
      where: 'actual_maintenance_date < ?',
      whereArgs: [now],
    );
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
