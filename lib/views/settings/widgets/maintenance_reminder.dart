part of '../settings_view.dart';

class _ReminderPeriodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextSubtitle(text: 'Bakım Hatırlatma Periyodu',),
        SizedBox(height: ConsSize.space / 4),
        _ReminderPeriodOptions(),
      ],
    );
  }
}

class _ReminderPeriodOptions extends StatelessWidget {
  final List<int> reminderPeriods = [1, 7, 30];
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
          reminderPeriods.length,
          (index) => _PeriodOption(
            "${reminderPeriods[index]} Gün",
            viewModel.selectedMaintenancePeriod,
            reminderPeriods[index],
            viewModel.setSelectedMaintenance,
          ),
        ),
      ),
    );
  }
}

class _PeriodOption extends StatelessWidget {
  final String label;
  final RxInt selectedValue;
  final int value;
  final Function(int) onSelect;

  const _PeriodOption(this.label, this.selectedValue, this.value, this.onSelect);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isSelected = selectedValue.value == value;
      return Expanded(
        child: InkWell(
          onTap: () => onSelect(value),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: isSelected ? Colors.blueGrey.shade700 : Colors.transparent,
              child: Center(
                child: TextBody(
                  text:label,  color: isSelected ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.bold,
                 
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}