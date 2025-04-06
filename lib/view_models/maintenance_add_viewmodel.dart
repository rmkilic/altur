import 'package:altur/constants/app_constant.dart';
import 'package:altur/controller/maintenance_controller.dart';
import 'package:altur/controller/settings_controller.dart';
import 'package:altur/data/database/daos/notification_dao.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:altur/data/services/local/notification_service.dart';
import 'package:altur/view_models/maintenance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaintenanceRecordFormViewModel extends GetxController {
   TextEditingController typeController = TextEditingController();
   TextEditingController dateController = TextEditingController();
   TextEditingController costController = TextEditingController();
   TextEditingController mileageController = TextEditingController();

  final MaintenanceRecordController maintenanceRecordController = Get.find();
  final MaintenanceViewModel maintanenceViewModel = Get.find();
  final SettingsController settingsController = Get.find();

  RxBool isInfo = false.obs;
  final int vehicleId;
  MaintenanceRecord? maintenance;

  MaintenanceRecordFormViewModel({required this.vehicleId, this.maintenance}) {
    isInfo.value = maintenance != null;
    if (isInfo.value) {
      load(maintenance!);
    }
    else
    {
      typeController = TextEditingController();
      dateController = TextEditingController();
      costController = TextEditingController();
      mileageController = TextEditingController();
    }
  }

  void load(MaintenanceRecord maintenance) {
    typeController.text = maintenance.type;
    dateController.text = AppConstants.dateFormat.format(maintenance.date);
    costController.text = maintenance.cost.toStringAsFixed(2);
    mileageController.text = maintenance.mileage.toString();
  }

  Future<void> onTapSave() async {
    if (_validateForm()) {
      MaintenanceRecord newRecord = MaintenanceRecord(
        type: typeController.text,
        date: AppConstants.dateFormat.parse(dateController.text),
        cost: double.parse(costController.text),
        mileage: int.parse(mileageController.text),
        vehicleId: vehicleId,
      );

      newRecord.id = await maintenanceRecordController.addMaintenanceRecord(newRecord);

      final DateTime notificationDate = newRecord.date.subtract(
        Duration(days: settingsController.selectedMaintenancePeriod.value),
      );

      await _scheduleNotification(newRecord, notificationDate);
      await maintanenceViewModel.loadRecords(vehicleId);
      Get.back();
    }
  }

  bool _validateForm() {
    return typeController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        costController.text.isNotEmpty &&
        mileageController.text.isNotEmpty;
  }

  Future<void> _scheduleNotification(MaintenanceRecord newRecord, DateTime notificationDate) async {
    final db = NotificationDao(databaseHelper: Get.find());
    await db.insertNotificationRecord(newRecord.id!, AppConstants.dateFormat.format(notificationDate), AppConstants.dateFormat.format(newRecord.date));
   
      await NotificationService().scheduleNotification(notificationDate, newRecord);
    
  }
}
