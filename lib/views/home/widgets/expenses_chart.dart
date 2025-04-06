part of '../home_view.dart';

class ExpensesChart extends StatelessWidget {
  final VehicleController vehicleController = Get.find();

  ExpensesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const ConsPadding.itemMargin(),
        child: Column(
          children: [
            SubTitleWidget(text: 'Harcamalar', callback: onTapTitle),
            _Chart()
          ],
        ),
      ),
    );
    
  }

  void onTapTitle() {
    if (vehicleController.selectedVehicle.value?.id != null) {
      Get.to(() => MaintenanceListView(vehicleId: vehicleController.selectedVehicle.value!.id!));
    }
  }
}

class _Chart extends StatelessWidget {
  _Chart();

  final VehicleController vehicleController = Get.find();
  final MaintenanceRecordController maintenanceRecordController = Get.find();
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final vehicleId = vehicleController.selectedVehicle.value?.id;
    if (vehicleId == null) {
      return Center(child: Text('Lütfen bir araç seçin.'));
    }

    if (maintenanceRecordController.recordsGraph.isEmpty) {
      maintenanceRecordController.loadMaintenanceRecords(vehicleId);
    }

    return Obx(() {


      final now = DateTime.now();
      final period = settingsController.selectedGraphPeriod.value;
      final startDate = DateTime(now.year, now.month - period, now.day);
      final endDate = now;

      final expenses = maintenanceRecordController.recordsGraph
          .where((record) => record.date.isAfter(startDate) && record.date.isBefore(endDate))
          .toList();

      if (expenses.isEmpty) {
        return Center(child: Text('Son $period ayda masraf kaydı bulunamadı.'));
      }

      final groupedExpenses = <DateTime, double>{};
      for (final record in expenses) {
        final date = DateTime(record.date.year, record.date.month, record.date.day);
        groupedExpenses[date] = (groupedExpenses[date] ?? 0) + record.cost;
      }

      final sortedDates = groupedExpenses.keys.toList()..sort();
      final spots = sortedDates.map((date) {
        final index = sortedDates.indexOf(date).toDouble();
        return FlSpot(index, groupedExpenses[date]!);
      }).toList();

      if (spots.isEmpty) {
        return Center(child: Text('Son $period ayda masraf kaydı bulunamadı.'));
      }

final minY = groupedExpenses.values.reduce((a, b) => a < b ? a : b);
final maxY = groupedExpenses.values.reduce((a, b) => a > b ? a : b);

// Eğer minY sıfırdan küçükse, 0'ı dahil etmek için minY'yi 0'a ayarlıyoruz.
double adjustedMinY = minY < 0 ? minY : 0;

return SizedBox(
  height: 300,
  child: LineChart(
    LineChartData(
      minY: adjustedMinY, // Yeni minY değeri
      maxY: maxY,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withValues(alpha:.3),
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey.withValues(alpha:.3),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return TextChart(
                text: value.toStringAsFixed(0),
                fontWeight: FontWeight.bold,
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
  sideTitles: SideTitles(
    showTitles: true,
    interval: 1, // <-- bu satır eklendi
    getTitlesWidget: (value, meta) {
      final dateIndex = value.toInt();
      if (dateIndex < 0 || dateIndex >= sortedDates.length) {
        return Container();
      }
      final date = sortedDates[dateIndex];
      return Padding(
        padding: const EdgeInsets.only(top: ConsSize.space / 2),
        child: Transform.rotate(
          angle: -70 * (3.141592653589793 / 180),
          child: TextChart(
            text: AppConstants.dateFormatDayMonth.format(date), // örn. 01/04
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    },
  ),
),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withValues(alpha: .5)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blueAccent,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.withValues(alpha: .5),
                Colors.blueAccent
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
              radius: 4,
              color: Colors.white,
              strokeWidth: 2,
              strokeColor: Colors.blueAccent,
            ),
          ),
        ),
      ],
    ),
  ),
);
});
  }
}
