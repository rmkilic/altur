
part of '../home_view.dart';

class VehicleDropdown extends StatelessWidget {
  final VehicleController vehicleController = Get.find();

  VehicleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (vehicleController.vehicles.isEmpty) {
        return TextBody(text:'Araç bulunamadı');
      }
      return dropdownCard();
    });
  }

  Widget dropdownCard() {
    return Card(
      child: Padding(
        padding: const ConsPadding.itemMargin(),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            itemHeight: ConsSize.space * 3,
            value: vehicleController.selectedVehicle.value?.id,
            isExpanded: true,
            icon: IconEnums.expand.iconWidget,
            items: vehicleController.vehicles.map((vehicle) {
              return DropdownMenuItem<int>(
                value: vehicle.id,
                child: dropdownItem(vehicle),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                vehicleController.selectVehicle(value);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget dropdownItem(Vehicle vehicle)
  {
    return ListTile(
      title: TextSubtitle(text:"${vehicle.brand.toUpperCaseTr()} ${vehicle.model}"),
      subtitle: TextBody(text:vehicle.licensePlate.toUpperCaseTr(),),
    );
  }
}