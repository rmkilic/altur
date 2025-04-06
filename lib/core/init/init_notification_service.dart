import 'dart:convert';

import 'package:altur/data/models/maintenance_record.dart';
import 'package:altur/views/maintenance/maintenance_add/maintenance_add_view.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationServiceInit {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _plugin.initialize(settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          _handleNotificationTap(response.payload!);
        }
      }
    );
  }

  static void _handleNotificationTap(String payload) {
    final data = jsonDecode(payload);
    final maintenance = MaintenanceRecord.fromMap(data);
    Get.to(() => MaintenanceAddView(vehicleId: maintenance.vehicleId, maintenance: maintenance));
  }
}
