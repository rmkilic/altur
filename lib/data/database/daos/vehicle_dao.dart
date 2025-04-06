
import 'package:altur/data/database/database_helper.dart';
import 'package:altur/data/models/vehicle.dart';
import 'package:sqflite/sqflite.dart';

class VehicleDao {
  final DatabaseHelper databaseHelper;

  VehicleDao({required this.databaseHelper});

  Future<void> insertVehicle(Vehicle vehicle) async {
    final db = await databaseHelper.database;
    await db.insert('TBL_VEHICLES', vehicle.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Vehicle>> getVehicles() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('TBL_VEHICLES');

    return List.generate(maps.length, (i) {
      return Vehicle.fromMap(maps[i]);
    });
  }
}