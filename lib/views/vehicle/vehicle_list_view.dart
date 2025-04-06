import 'package:altur/constants/cons_padding.dart';
import 'package:altur/controller/vehicle_controller.dart';
import 'package:altur/data/models/vehicle.dart';
import 'package:altur/enums/icon_enums.dart';
import 'package:altur/views/vehicle/vehicle_add_view.dart';
import 'package:altur/widgets/common_appbar.dart';
import 'package:altur/widgets/page_title.dart';
import 'package:altur/widgets/text/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VehicleListView extends StatelessWidget {
  final VehicleController vehicleController = Get.put(VehicleController(vehicleDatabaseService: Get.find()));

   VehicleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  CommonAppBar(),
        body: body(),
        floatingActionButton: fabButton()
    );
  }

  Widget fabButton()
  {
    return FloatingActionButton(
          onPressed: () {
            Get.to(() => VehicleAddView());
          },
          child: Icon(IconEnums.add.icon),
        );
  }

  Widget body()
  {
    return Padding(
          padding: const ConsPadding.itemMargin(),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             PageTitle(title: "Araç Listesi"),
             list()
           ],),
        );
  }

  Widget list()
  {
    return Obx((){
      return Expanded(
      child: ListView.builder(
        itemCount: vehicleController.vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicleController.vehicles[index];
          return listItem(vehicle);
        },
      ),
    );
    });
  }

  Widget listItem(Vehicle vehicle)
  {
    return Card(
            child: ListTile(
              title: TextSubtitle(text:'${vehicle.brand} ${vehicle.model}'),
              subtitle: TextBody(text:'Plaka: ${vehicle.licensePlate}\nKilometre: ${vehicle.currentMileage} km'),
              isThreeLine: true,
            ),
          );
  }
}