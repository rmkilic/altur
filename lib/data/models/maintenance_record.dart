class MaintenanceRecord {
  int? id;
  final String type;
  final DateTime date;
  final double cost;
  final int mileage;
  final int vehicleId;

  MaintenanceRecord({
    this.id,
    required this.type,
    required this.date,
    required this.cost,
    required this.mileage,
    required this.vehicleId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'date': date.toIso8601String(),
      'cost': cost,
      'mileage': mileage,
      'vehicleId': vehicleId,
    };
  }

  factory MaintenanceRecord.fromMap(Map<String, dynamic> map) {
    return MaintenanceRecord(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      cost: map['cost'],
      mileage: map['mileage'],
      vehicleId: map['vehicleId'],
    );
  }
}