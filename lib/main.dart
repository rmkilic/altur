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

  //  Bağımlılıkları başlat
  await initDependencies();

  //  Bildirimleri başlat
  await NotificationServiceInit.initializeNotifications();

  //  Bildirim izni iste
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

