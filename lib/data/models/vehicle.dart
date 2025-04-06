class Vehicle {
  final int? id;
  final String brand;
  final String model;
  final String licensePlate;
  final int currentMileage;

  Vehicle({
    this.id,
    required this.brand,
    required this.model,
    required this.licensePlate,
    required this.currentMileage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'licensePlate': licensePlate,
      'currentMileage': currentMileage,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      brand: map['brand'],
      model: map['model'],
      licensePlate: map['licensePlate'],
      currentMileage: map['currentMileage'],
    );
  }
}