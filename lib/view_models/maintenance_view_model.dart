import 'package:altur/controller/maintenance_controller.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:get/get.dart';

class MaintenanceViewModel extends GetxController {
  var pastRecords = <MaintenanceRecord>[].obs;
  var upcomingRecords = <MaintenanceRecord>[].obs;
  final MaintenanceRecordController maintenanceRecordController;

  MaintenanceViewModel({required this.maintenanceRecordController});

  Future<void> loadRecords(int vehicleId) async {
    await maintenanceRecordController.loadMaintenanceRecords(vehicleId);
    await maintenanceRecordController.loadUpcomingMaintenanceRecords(vehicleId);
    var today = DateTime.now();

    pastRecords.value = maintenanceRecordController.recordsGraph.where((record) => record.date.isBefore(today)).toList();
    upcomingRecords.value = maintenanceRecordController.recordsReminder.where((record) => record.date.isAfter(today)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
      upcomingRecords;
  }

  Future<void> loadAllUpcomingRecords(int vehicleId) async {
    await maintenanceRecordController.loadUpcomingMaintenanceRecords(vehicleId);
    var today = DateTime.now();

    upcomingRecords.value = maintenanceRecordController.recordsReminder.where((record) => record.date.isAfter(today)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }
}