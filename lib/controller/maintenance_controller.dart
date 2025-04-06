
import 'package:altur/controller/settings_controller.dart';
import 'package:altur/data/database/daos/maintenance_dao.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:get/get.dart';


class MaintenanceRecordController extends GetxController {
  var recordsGraph = <MaintenanceRecord>[].obs;
  var recordsReminder = <MaintenanceRecord>[].obs;


  final MaintenanceDao maintenanceRecordDatabaseService;
  final SettingsController settingsController = Get.find();

  MaintenanceRecordController({required this.maintenanceRecordDatabaseService});

  Future<void> loadMaintenanceRecords(int vehicleId) async {

 
      final now = DateTime.now();
      final period = settingsController.selectedGraphPeriod.value;
      final startDate = DateTime(now.year, now.month - period, now.day);

      recordsGraph.value = await maintenanceRecordDatabaseService.getMaintenanceRecordsInPeriod(vehicleId, startDate, now);
    recordsGraph;
  }

  Future<void> loadUpcomingMaintenanceRecords(int vehicleId, {int? reminderPeriod}) async {

      final now = DateTime.now();
      DateTime? endDate;
      if (reminderPeriod != null) {
        endDate = now.add(Duration(days: reminderPeriod));
      }
      recordsReminder.value = await maintenanceRecordDatabaseService.getUpcomingMaintenanceRecords(vehicleId, endDate: endDate);
      recordsReminder;
  }

  Future<int> addMaintenanceRecord(MaintenanceRecord record) async {
    int id = await maintenanceRecordDatabaseService.insertMaintenanceRecord(record);
    await loadMaintenanceRecords(record.vehicleId);
    return id;
  }
}
