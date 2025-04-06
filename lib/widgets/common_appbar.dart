import 'package:altur/constants/cons_padding.dart';
import 'package:altur/controller/vehicle_controller.dart';
import 'package:altur/enums/image_enums.dart';
import 'package:altur/views/home/home_view.dart';
import 'package:altur/views/settings/settings_view.dart';
import 'package:altur/views/vehicle/vehicle_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {


   CommonAppBar({super.key});
 final VehicleController vehicleController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(preferredSize: preferredSize, child: Padding(
        padding: const ConsPadding.itemMargin(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            settings(),
            logo(),
            car(),
          ],
        ),
      )),
    );
  }

  Widget settings()
  {
    return InkWell(
      onTap: (){
        onTapFunction(navigateSettings);
        
         // Get.to(() => SettingsView());

      },
      child: ImageEnums.settings.imageWidget,
    );
  }

  Widget logo()
  {
    return InkWell(
      onTap: (){
        onTapFunction(navigateHome);
        
         // Get.to(() => HomeView());

      },
      child: ImageEnums.logo.imageWidget,
    );
  }

  Widget car()
  {
    return InkWell(
      onTap: (){
        onTapFunction(navigateVehicleList);
        //  Get.to(() => VehicleListView());
        
      },
      child: ImageEnums.carList.imageWidget,
    );
  }

  navigateVehicleList()
  {
    Get.to(() => VehicleListView());
  }
  navigateHome()
  {
    Get.to(() => HomeView());
  }
  navigateSettings()
  {
    Get.to(() => SettingsView());
    
  }

  onTapFunction(VoidCallback callback)
  {
     // Eğer araç listesi boşsa, kullanıcıya bir mesaj göster.
        if (vehicleController.vehicles.isEmpty) {
          _showNoVehicleDialog();
        } else {
          // Araç varsa, VehicleListView sayfasına git.
          callback();
        }
  }

    // Araç eklenmesi gerektiğini bildiren bir dialog göster
  void _showNoVehicleDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Araç Ekleyin'),
        content: Text('Projeyi Kullanabilmek için araç eklemelisiniz !'),
        actions: [
          
          TextButton(
            onPressed: () {
              Get.back(); // Dialogu kapat
            },
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}