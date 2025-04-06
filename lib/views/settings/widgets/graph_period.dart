part of '../settings_view.dart';

class _GraphPeriodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSubtitle(text:'Grafik Periyodu' ),
        SizedBox(height: ConsSize.space / 4),
        _GraphPeriodOptions(),
      ],
    );
  }
}

class _GraphPeriodOptions extends StatelessWidget {
  final List<int> graphValues = [1, 6, 12];
  final SettingsController viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.shade100,
      ),
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: List.generate(
          graphValues.length,
          (index) => _PeriodOption(
            "${graphValues[index]} Ay",
            viewModel.selectedGraphPeriod,
            graphValues[index],
            viewModel.setSelectedGraphPeriod,
          ),
        ),
      ),
    );
  }
}