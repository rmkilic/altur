
import 'dart:convert';

import 'package:altur/constants/app_constant.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  /// **Bildirimleri Başlat**
  Future<void> init() async {
    tz.initializeTimeZones(); // Zaman dilimlerini başlat

    // Android ayarları
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS ayarları (Gerekirse)
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    // Genel başlatma ayarları
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
    await _createNotificationChannel();
  }

  /// **Bildirim Kanalını Oluştur**
  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id', // Kanal ID'si
      'Bakım Bildirimleri',
      description: 'Bu kanalda Bakım Bildirimleri Gösterilir',
      importance: Importance.high,
    );

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.createNotificationChannel(channel);
  }

  /// **İleri Tarihli Bildirim Planla**
  Future<void> scheduleNotification(DateTime scheduledTime, MaintenanceRecord payload) async {
    DateTime now = DateTime.now();
    DateTime nowOnlyDate = DateTime(now.year, now.month, now.day);

  // 📌 Map'i JSON formatına çevirerek payload olarak ekleyelim
  

    if(scheduledTime == nowOnlyDate)
    {
     await showNotification(payload);
    }
    else if(scheduledTime.isAfter(nowOnlyDate))
    {
      await showZonedSchedule(scheduledTime, payload);
    }


  }

  Future<void> showZonedSchedule(DateTime scheduledTime, MaintenanceRecord payload)async
  {
    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);
    String payloadValue = jsonEncode(payload.toMap());


        await _notificationsPlugin.zonedSchedule(
      payload.id!,
      "Bakım Hatırlatıcı",
      "[${AppConstants.dateFormat.format(payload.date)}] - ${payload.type}" ,
      tzScheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id', // Aynı kanal ID'si
          'Bakım Bildirimleri',
          channelDescription: 'Bu kanalda Bakım Bildirimleri Gösterilir',
          icon:'ic_notification',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payloadValue

    );
  }

    Future<void> showNotification(MaintenanceRecord payload) async {

    const NotificationDetails platformDetails =  NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id', // Aynı kanal ID'si
          'Bakım Bildirimleri',
          channelDescription: 'Bu kanalda Bakım Bildirimleri Gösterilir',
          icon:'ic_notification',
          importance: Importance.high,
          priority: Priority.high,
        ),
      );

    String payloadValue = jsonEncode(payload.toMap());
    await _notificationsPlugin.show(
      payload.id!,
      "Bakım Hatırlatıcı",
      "[${AppConstants.dateFormat.format(payload.date)}] - ${payload.type}" ,
      platformDetails,
      payload: payloadValue

    );
  }



  /// **Tüm Bildirimleri İptal Et**
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
