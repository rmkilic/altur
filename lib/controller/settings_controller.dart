
import 'package:altur/constants/app_constant.dart';
import 'package:altur/data/database/daos/maintenance_dao.dart';
import 'package:altur/data/database/daos/notification_dao.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:altur/data/services/local/notification_service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsController extends GetxController {
  static const List<int> maintenancePeriodList = [1, 7, 30];
  var selectedMaintenancePeriod = 7.obs;
  static const List<int> graphPeriodList = [1, 6, 12];
  var selectedGraphPeriod = 6.obs;
  late Box settingsBox;
  final NotificationService _notificationService = NotificationService();
  final NotificationDao _maintenanceNotificationService ;

  SettingsController(this._maintenanceNotificationService);

  @override
  void onInit() {
    super.onInit();
    settingsBox = Hive.box(AppConstants.hiveBoxName);
    _loadSelectedValues();

  }

  void _loadSelectedValues() {
    _loadMaintenanceValue();
    _loadGraphValue();
  }

  void _loadMaintenanceValue() {
    final int? storedValue = settingsBox.get('maintenancePeriod');
    if (storedValue != null && maintenancePeriodList.contains(storedValue)) {
      selectedMaintenancePeriod.value = storedValue;
    } else {
      selectedMaintenancePeriod.value = maintenancePeriodList.first;
    }
  }

  void _loadGraphValue() {
    final int? storedValue = settingsBox.get('graphPeriod');
    if (storedValue != null && graphPeriodList.contains(storedValue)) {
      selectedGraphPeriod.value = storedValue;
    } else {
      selectedGraphPeriod.value = graphPeriodList.first;
    }
  }

  Future<void> save()async {
    settingsBox.put('maintenancePeriod', selectedMaintenancePeriod.value);
    settingsBox.put('graphPeriod', selectedGraphPeriod.value);
    await _scheduleNotifications();
  
  }

  void setSelectedMaintenance(int item) {
    if (maintenancePeriodList.contains(item)) {
      selectedMaintenancePeriod.value = item;

    }
  }

  void setSelectedGraphPeriod(int item) {
    if (graphPeriodList.contains(item)) {
      selectedGraphPeriod.value = item;
    }
  }

  Future<void> _scheduleNotifications() async {
    await _notificationService.cancelAllNotifications();

    final List<Map<String, dynamic>> notifications = await _maintenanceNotificationService.getAllNotifications();
MaintenanceDao maintenanceDb = MaintenanceDao(databaseHelper: Get.find());
    for (var notification in notifications) {
      final int maintenanceRecordId = notification['maintenance_record_id'];
      final DateTime actualMaintenanceDate = AppConstants.dateFormat.parse(notification['actual_maintenance_date']);
      final DateTime newNotificationDate = actualMaintenanceDate.subtract(Duration(days: selectedMaintenancePeriod.value));
      MaintenanceRecord record =  await maintenanceDb.getMaintenanceWithId(id: maintenanceRecordId);
      
        await _notificationService.scheduleNotification(
          newNotificationDate,record
        );
        await _maintenanceNotificationService.updateNotificationRecord(maintenanceRecordId, newNotificationDate.toIso8601String());
      
    }
  }
}