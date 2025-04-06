import 'package:altur/constants/app_constant.dart';
import 'package:altur/constants/cons_padding.dart';
import 'package:altur/constants/cons_size.dart';
import 'package:altur/controller/settings_controller.dart';
import 'package:altur/controller/vehicle_controller.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:altur/view_models/maintenance_view_model.dart';
import 'package:altur/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpcomingRecordListView extends StatelessWidget {
    final settigsViewModel = Get.find<SettingsController>();

   UpcomingRecordListView({super.key});

  @override
  Widget build(BuildContext context) {
    final maintenanceViewModel = Get.find<MaintenanceViewModel>();
    
final vehicleController = Get.find<VehicleController>();
      final vehicleId = vehicleController.selectedVehicle.value?.id;
      if (vehicleId != null) {
        maintenanceViewModel.loadAllUpcomingRecords(vehicleId);
      }
    return Scaffold(
      body: Obx(() {
        if (maintenanceViewModel.upcomingRecords.isEmpty) {
          return Center(child: Text('Yaklaşan bakım kaydı bulunamadı.'));
        }
        return Padding(
          padding: const ConsPadding.itemMargin(),
          child: Column(
            children: [
              PageTitle(title: "Yaklaşan Bakımlar"),
              Expanded(
                child: ListView.builder(
                  itemCount: maintenanceViewModel.upcomingRecords.length,
                  itemBuilder: (context, index) {
                    return remindItem(context, maintenanceViewModel.upcomingRecords[index]);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget remindItem(BuildContext context, MaintenanceRecord data) {
    DateTime now = DateTime.now();
    DateTime maintenanceDate = data.date;
    int differenceInDays = maintenanceDate.difference(now).inDays;
    Color indicatorColor = Colors.red;
    return Card(
      child: Padding(
        padding: const ConsPadding.itemMargin(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                AppConstants.dateFormat.format(data.date),
                style: context.textTheme.bodyMedium,
              ),
            ),  
            
            Text(
              data.type,
              style: context.textTheme.titleMedium,
            ), 
            Text(
                    '${data.mileage} km',
                    style: context.textTheme.bodyMedium,
                  ),
          
            Visibility(
              visible: settigsViewModel.selectedMaintenancePeriod.value >= differenceInDays,
              child: Text(
                getMaintenanceMessage(differenceInDays),
                style: context.textTheme.bodyMedium!.copyWith(
                  color: indicatorColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ), 
              Align(
                alignment: Alignment.bottomRight,
                child: Text('${data.cost} ₺', style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.red),)),
                    
            
            SizedBox(height: ConsSize.space / 2),
            
          ],
        ),
      ),
    );
  }

  String getMaintenanceMessage(int day) {
    if (day == 0) {
      return "Bakım Bugün!";
    } else {
      return "${day.toString()} Gün Kaldı";
    }
  }
}