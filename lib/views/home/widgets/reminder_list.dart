
part of '../home_view.dart';


class ReminderList extends StatelessWidget with ReminderListMixin {
  ReminderList({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleId = vehicleController.selectedVehicle.value?.id;
    if (vehicleId == null) {
      return Center(child: TextBody(text:'Lütfen bir araç seçin.'));
    }

    loadReminderList();

    return Obx(() {


      final upcomingMaintenances = getMaintenanceList();


      return Card(
        child: Padding(
          padding: const ConsPadding.itemMargin(),
          child: Column(
            children: [
              SubTitleWidget(text: 'Yaklaşan Bakımlar', buttonText: upcomingMaintenances.isEmpty ? "Ekle" : "Tümü", callback: onTapTitle),
              remindList(upcomingMaintenances),
            ],
          ),
        ),
      );
    });
  }

  remindList(List<MaintenanceRecord> upcomingMaintenances)
  {

    if (upcomingMaintenances.isEmpty) {
      return   TextBody(text: 'Yaklaşan bakım bulunamadı.');
      }
      else
      {
        return Expanded(
          child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(upcomingMaintenances.length,
                          (index) => remindItem(upcomingMaintenances[index])),
                    ),
                  ),
        );
      }
  }

    Widget remindItem(MaintenanceRecord data) {
    int differenceInDays = getDifferenceInDays(data);
    Color indicatorColor = getIndicatorColor(differenceInDays);
    return Card(
      child: Padding(
        padding: const ConsPadding.itemMargin(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextSubtitle(text: data.type),
            TextBody(text: "${differenceInDays.toString()} Gün Kaldı", color: indicatorColor),
            SizedBox(height: ConsSize.space / 2),
            DayAnimation(differenceInDays: differenceInDays, period: settingsController.selectedMaintenancePeriod.value, indicatorColor: indicatorColor),
          ],
        ),
      ),
    );
  }
}
