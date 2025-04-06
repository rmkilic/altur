

import 'package:altur/constants/app_constant.dart';
import 'package:altur/constants/cons_padding.dart';
import 'package:altur/constants/cons_size.dart';
import 'package:altur/controller/maintenance_controller.dart';
import 'package:altur/controller/settings_controller.dart';
import 'package:altur/controller/vehicle_controller.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:altur/data/models/vehicle.dart';
import 'package:altur/enums/icon_enums.dart';
import 'package:altur/views/maintenance/maintenance_list/maintenance_list_view.dart';
import 'package:altur/widgets/common_appbar.dart';
import 'package:altur/widgets/day_animation.dart';
import 'package:altur/widgets/subtitle_widget.dart';
import 'package:altur/widgets/text/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turkish/turkish.dart';

part 'mixin/reminder_list_mixin.dart';
part 'widgets/expenses_chart.dart';
part 'widgets/reminder_list.dart';
part 'widgets/vehicle_dropdown.dart';

class HomeView extends StatelessWidget {
  final VehicleController vehicleController = Get.find();
  final MaintenanceRecordController maintenanceRecordController = Get.find();
  final SettingsController settingsController = Get.find();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: FutureBuilder<void>(
        future: Future.wait([
          vehicleController.loadVehicles(),
          if (vehicleController.selectedVehicle.value != null)
            maintenanceRecordController.loadMaintenanceRecords(vehicleController.selectedVehicle.value!.id!),
          if (vehicleController.selectedVehicle.value != null)
            maintenanceRecordController.loadUpcomingMaintenanceRecords(vehicleController.selectedVehicle.value!.id!, reminderPeriod: settingsController.selectedMaintenancePeriod.value),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (vehicleController.vehicles.isEmpty) {
            return Center(child: Text('Lütfen bir araç ekleyin.'));
          }

          final vehicleId = vehicleController.selectedVehicle.value?.id;
          if (vehicleId == null) {
            return Center(child: Text('Lütfen bir araç seçin.'));
          }

          return modernBody();
        },
      ),
    );
  }

  Widget modernBody() {
    return Padding(
      padding: const ConsPadding.itemMargin(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VehicleDropdown(),
          SizedBox(height: 20),
          ExpensesChart(),
          SizedBox(height: 20),
          Expanded(child: ReminderList()),
        ],
      ),
    );
  }
}

/* class HomeView extends StatelessWidget {
  final VehicleController vehicleController = Get.find();
  final MaintenanceRecordController maintenanceRecordController = Get.find();
  final SettingsController settingsController = Get.find();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<void>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (vehicleController.vehicles.isEmpty) {
       /*    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Get.to(VehicleAddView());

          });
 */
        return Center(child: TextBody(text:'Lütfen bir araç ekleyin.'));
        }

        final vehicleId = vehicleController.selectedVehicle.value?.id;
        if (vehicleId == null) {
          return Center(child: TextBody(text:'Lütfen bir araç seçin.'));
        }

        return _body();
      },
    );
  }

  Future<void> _loadData() async {
    await Future.wait([
      vehicleController.loadVehicles(),
      if (vehicleController.selectedVehicle.value != null)
        maintenanceRecordController.loadMaintenanceRecords(
          vehicleController.selectedVehicle.value!.id!,
        ),
      if (vehicleController.selectedVehicle.value != null)
        maintenanceRecordController.loadUpcomingMaintenanceRecords(
          vehicleController.selectedVehicle.value!.id!,
          reminderPeriod: settingsController.selectedMaintenancePeriod.value,
        ),
    ]);
  }

  Widget _body() {
    return Padding(
      padding: const ConsPadding.itemMargin(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VehicleDropdown(),
          SizedBox(height: 20),
          ExpensesChart(),
          SizedBox(height: 20),
          Expanded(child: ReminderList()),
        ],
      ),
    );
  }
}
 */