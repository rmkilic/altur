import 'package:altur/constants/app_constant.dart';
import 'package:altur/constants/cons_padding.dart';
import 'package:altur/constants/cons_size.dart';
import 'package:altur/controller/vehicle_controller.dart';
import 'package:altur/data/models/vehicle.dart';
import 'package:altur/views/vehicle/vehicle_list_view.dart';
import 'package:altur/widgets/common_appbar.dart';
import 'package:altur/widgets/custom_button.dart';
import 'package:altur/widgets/input_area.dart';
import 'package:altur/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VehicleAddView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _mileageController = TextEditingController();

  final VehicleController vehicleController = Get.find();

  VehicleAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: body()
    );
  }

  Widget body()
  {
    return Padding(
        padding: const ConsPadding.itemMargin(),
        child: Column(
          children: [
            PageTitle(title: "Yeni Araç"),
            _form()           
          ],
        ),
      );
  }

  Widget _form()
  {
    return  Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InputArea(title: "Marka", controller: _brandController, inputFormatters: AppConstants.upperCharacterFormatter,),
                      InputArea(title: "Model", controller: _modelController, inputFormatters: AppConstants.upperWordFormatter, keyboardType: TextInputType.visiblePassword,),
                      InputArea(title: "Plaka", controller: _licensePlateController, inputFormatters: AppConstants.upperCharacterFormatter, keyboardType: TextInputType.visiblePassword,),
                      InputArea(title: "Kilometre", controller: _mileageController, keyboardType: TextInputType.number,),                         
                      SizedBox(height: ConsSize.space),
                      CustomButton(title: "Kaydet", callback: ()async{
                          if (_formKey.currentState!.validate()) {
                            final newVehicle = Vehicle(
                              brand: _brandController.text,
                              model: _modelController.text,
                              licensePlate: _licensePlateController.text,
                              currentMileage: int.parse(_mileageController.text),
                            );
                            await vehicleController.addVehicle(newVehicle);
                            if(vehicleController.vehicles.length == 1)
                            {
                              Get.to(VehicleListView());
                            }
                            else
                            {
                            Get.back();

                            }
                          }
                        })
                    ],
                  ),
                ),
              ),
            );
  }
}