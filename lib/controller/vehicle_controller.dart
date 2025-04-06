
import 'package:altur/data/database/daos/vehicle_dao.dart';
import 'package:altur/data/models/vehicle.dart';
import 'package:get/get.dart';

class VehicleController extends GetxController {
  var vehicles = <Vehicle>[].obs;
  var selectedVehicle = Rxn<Vehicle>();
  final VehicleDao vehicleDatabaseService;

  VehicleController({required this.vehicleDatabaseService});

  @override
  void onInit() {
    super.onInit();
    loadVehicles();
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    await vehicleDatabaseService.insertVehicle(vehicle);
    await loadVehicles();
  }

  Future<void> loadVehicles() async {
    vehicles.value = await vehicleDatabaseService.getVehicles();
    if (vehicles.isNotEmpty) {
      selectedVehicle.value ??= vehicles.first;
    }
  }

  void selectVehicle(int vehicleId) {
    selectedVehicle.value = vehicles.firstWhere((vehicle) => vehicle.id == vehicleId);
  }
}