import 'package:altur/controller/maintenance_controller.dart';
import 'package:altur/controller/settings_controller.dart';
import 'package:altur/controller/vehicle_controller.dart';
import 'package:altur/data/database/daos/maintenance_dao.dart';
import 'package:altur/data/database/daos/notification_dao.dart';
import 'package:altur/data/database/daos/vehicle_dao.dart';
import 'package:altur/data/database/database_helper.dart';
import 'package:altur/view_models/maintenance_view_model.dart';
import 'package:get/get.dart';

Future<void> initDependencies() async {
  final dbHelper = DatabaseHelper();
  Get.put(dbHelper);

  final notificationDao = NotificationDao(databaseHelper: dbHelper);
  Get.put(SettingsController(notificationDao));
  Get.put(VehicleDao(databaseHelper: dbHelper));
  Get.put(MaintenanceDao(databaseHelper: dbHelper));
  Get.put(VehicleController(vehicleDatabaseService: Get.find()));
  Get.put(MaintenanceRecordController(maintenanceRecordDatabaseService: Get.find()));
  Get.put(MaintenanceViewModel(maintenanceRecordController: Get.find()));  // MaintenanceViewModel'i buradan başlatıyoruz

  await dbHelper.removeExpiredNotifications();
}
