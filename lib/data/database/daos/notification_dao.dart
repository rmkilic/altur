
import 'package:altur/data/database/database_helper.dart';

class NotificationDao {
  final DatabaseHelper databaseHelper;

  NotificationDao({required this.databaseHelper});

  Future<int> insertNotificationRecord(int maintenanceRecordId, String notificationDate, String actualMaintenanceDate) async {
    try
    {
      final db = await databaseHelper.database;
    int id =await db.insert('TBL_NOTIFICATION', {
      'maintenance_record_id': maintenanceRecordId,
      'notification_date': notificationDate,
      'actual_maintenance_date': actualMaintenanceDate,
    });
    return id;
    }
    catch(e)
    {
      throw Exception(e);
    }
  }

  Future<void> updateNotificationRecord(int maintenanceRecordId, String newNotificationDate) async {
    final db = await databaseHelper.database;
    await db.update(
      'TBL_NOTIFICATION',
      {'notification_date': newNotificationDate},
      where: 'maintenance_record_id = ?',
      whereArgs: [maintenanceRecordId],
    );
  }

  Future<List<Map<String, dynamic>>> getAllNotifications() async {
    final db = await databaseHelper.database;
    var item = await db.query('TBL_NOTIFICATION');
    return item;
  }

  Future<void> deleteAllNotifications() async {
    final db = await databaseHelper.database;
    await db.delete('TBL_NOTIFICATION');
  }

  Future<void> removeExpiredNotifications() async {
    final db = await databaseHelper.database;
    final now = DateTime.now().toIso8601String();

    await db.delete(
      'TBL_NOTIFICATION',
      where: 'actual_maintenance_date < ?',
      whereArgs: [now],
    );
  }
}