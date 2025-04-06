/* import 'dart:convert';

import 'package:altur/constants/app_constant.dart';
import 'package:altur/controller/maintenance_controller.dart';
import 'package:altur/controller/settings_controller.dart';
import 'package:altur/controller/vehicle_controller.dart';
import 'package:altur/data/database/daos/maintenance_dao.dart';
import 'package:altur/data/database/daos/notification_dao.dart';
import 'package:altur/data/database/daos/vehicle_dao.dart';
import 'package:altur/data/database/database_helper.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:altur/views/home/home_view.dart';
import 'package:altur/views/maintenance/maintenance_add/maintenance_add_view.dart';
import 'package:altur/views/vehicle/vehicle_add_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main()async {

  await Hive.initFlutter();
  await Hive.openBox(AppConstants.hiveBoxName);
  Get.put(DatabaseHelper());
  final NotificationDao maintenanceNotificationService = NotificationDao(databaseHelper: Get.find(),);

  Get.put(SettingsController( maintenanceNotificationService));
  //Get.put(SettingsController());
  Get.put(VehicleDao(databaseHelper: Get.find()));
  Get.put(MaintenanceDao(databaseHelper: Get.find()));
  Get.put(VehicleController(vehicleDatabaseService: Get.find()));

  Get.put(MaintenanceRecordController(maintenanceRecordDatabaseService: Get.find()));
  final DatabaseHelper databaseHelper = DatabaseHelper();

  // Uygulama açılırken eski bildirimleri temizle
  await databaseHelper.removeExpiredNotifications();
/*   
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final MaintenanceDao maintenanceRecordService = MaintenanceDao(databaseHelper: databaseHelper);
 */

 await _requestPermissions();  // 📌 Bildirim izni iste 
await _initializeNotifications();

  runApp(MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _initializeNotifications() async {
  // Zaman dilimi ayarları
  tz.initializeTimeZones();

  // Android için ayarlar
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('ic_notification');

  // iOS için ayarlar (Gerekirse)
  const DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings();

  // Genel başlatma ayarları
  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  // Plugin'i başlat
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  onDidReceiveNotificationResponse: (NotificationResponse response) {
    if (response.payload != null) {
      _handleNotificationTap(response.payload!);
    }
  },
  );
  
}

void _handleNotificationTap(String payload) {
  print("Bildirim Payload: $payload");
    Map<String, dynamic> data = jsonDecode(payload);
    MaintenanceRecord data2 = MaintenanceRecord.fromMap(data);

  // 📌 GetX kullanarak sayfaya yönlendirme yapıyoruz.
  Get.to(() => MaintenanceAddView(vehicleId: data2.vehicleId, maintenance: data2,));
}


Future<void> _requestPermissions() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  final VehicleController vehicleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Maintenance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.black87,
        )
      ),
      home: vehicleController.vehicles.value.isEmpty ? VehicleAddView() : HomeView(),
    );
  }
} */
import 'package:altur/constants/app_constant.dart';
import 'package:altur/controller/vehicle_controller.dart';
import 'package:altur/core/init/init_dependencies.dart';
import 'package:altur/core/init/init_notification_service.dart';
import 'package:altur/core/init/init_permission_service.dart';
import 'package:altur/views/home/home_view.dart';
import 'package:altur/views/vehicle/vehicle_add_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(AppConstants.hiveBoxName);

  // Zaman dilimi ayarları
  tz.initializeTimeZones();

  // 📦 Bağımlılıkları başlat
  await initDependencies();

  // 📩 Bildirimleri başlat
  await NotificationServiceInit.initializeNotifications();

  // 🔐 Bildirim izni iste
  await PermissionServiceInit.requestNotificationPermission();

  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleController = Get.find<VehicleController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ALTUR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cardTheme: const CardTheme(
          color: Colors.white,
          shadowColor: Colors.black87,
        )
      ),
      home: Obx(() {
        return vehicleController.vehicles.isEmpty
            ? VehicleAddView()
            : HomeView();
      }),
    );
  }
}

