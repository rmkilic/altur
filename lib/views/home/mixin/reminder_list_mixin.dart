
part of '../home_view.dart';

mixin ReminderListMixin {
  final VehicleController vehicleController = Get.find();
  final MaintenanceRecordController maintenanceRecordController = Get.find();
  final SettingsController settingsController = Get.find();

  void loadReminderList() {
    if (vehicleController.selectedVehicle.value != null) {
      final reminderPeriod = settingsController.selectedMaintenancePeriod.value;
      maintenanceRecordController.loadUpcomingMaintenanceRecords(vehicleController.selectedVehicle.value!.id!, reminderPeriod: reminderPeriod);
    }
  }

  List<MaintenanceRecord> getMaintenanceList() {
    final now = DateTime.now();
    final reminderPeriod = settingsController.selectedMaintenancePeriod.value;
    final endDate = now.add(Duration(days: reminderPeriod));

    return maintenanceRecordController.recordsReminder
        .where((record) =>
            record.date.isAfter(now) && record.date.isBefore(endDate))
        .toList();
  }

  void onTapTitle() {
    Get.to(() => MaintenanceListView(
          vehicleId: vehicleController.vehicles.first.id!,
          initialIndex: 1,
        ));
  }

  int getDifferenceInDays(MaintenanceRecord data) {
    DateTime now = DateTime.now();
    DateTime onlyDate = DateTime(now.year, now.month, now.day);
    DateTime maintenanceDate = data.date;
    return maintenanceDate.difference(onlyDate).inDays;
  }

  Color getIndicatorColor(int differenceInDays) {
    return differenceInDays <= 3
        ? Colors.red
        : differenceInDays <= 7
            ? Colors.orange
            : Colors.green;
  }
}