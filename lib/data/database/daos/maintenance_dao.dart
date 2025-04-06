
import 'package:altur/data/database/database_helper.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:sqflite/sqflite.dart';

class MaintenanceDao {
  final DatabaseHelper databaseHelper;

  MaintenanceDao({required this.databaseHelper});

  Future<int> insertMaintenanceRecord(MaintenanceRecord record) async {
    final db = await databaseHelper.database;
    return await db.insert('TBL_MAINTENANCE', record.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }



  Future<List<MaintenanceRecord>> getMaintenanceRecordsInPeriod(int vehicleId, DateTime startDate, DateTime endDate) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'TBL_MAINTENANCE',
      where: 'vehicleId = ? AND date >= ? AND date <= ?',
      whereArgs: [vehicleId, startDate.toIso8601String(), endDate.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return MaintenanceRecord.fromMap(maps[i]);
    });
  }

    Future<MaintenanceRecord> getMaintenanceWithId({required int id}) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'TBL_MAINTENANCE',
      where: 'id = ?',
      whereArgs: [id],
    );

 
      return MaintenanceRecord.fromMap(maps.first);
   
  }

  Future<List<MaintenanceRecord>> getUpcomingMaintenanceRecords(int vehicleId, {DateTime? endDate}) async {
    final db = await databaseHelper.database;
    final List<String> conditions = ['vehicleId = ?', 'date > ?'];
    final List<Object?> whereArgs = [vehicleId, DateTime.now().toIso8601String()];

    if (endDate != null) {
      conditions.add('date <= ?');
      whereArgs.add(endDate.toIso8601String());
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'TBL_MAINTENANCE',
      where: conditions.join(' AND '),
      whereArgs: whereArgs,
    );

    return maps.map((map) => MaintenanceRecord.fromMap(map)).toList();
  }
}