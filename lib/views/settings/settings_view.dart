import 'package:altur/constants/cons_padding.dart';
import 'package:altur/constants/cons_size.dart';
import 'package:altur/controller/settings_controller.dart';
import 'package:altur/data/database/daos/notification_dao.dart';
import 'package:altur/data/database/database_helper.dart';
import 'package:altur/views/home/home_view.dart';
import 'package:altur/widgets/common_appbar.dart';
import 'package:altur/widgets/custom_button.dart';
import 'package:altur/widgets/page_title.dart';
import 'package:altur/widgets/text/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'widgets/graph_period.dart';
part 'widgets/maintenance_reminder.dart';

class SettingsView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SettingsView({super.key});



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CommonAppBar(),
      body: body(),
    );
  }

  Widget body()
  {

    return Padding(
        padding: const ConsPadding.itemMargin(),
        child: Column(
          children: [
            PageTitle(title: "Ayarlar"),
            _form()
          ],
        ),
      );
  }

  Widget _form()
  {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final NotificationDao maintenanceNotificationService = NotificationDao(databaseHelper: databaseHelper);
  final SettingsController viewModel = Get.put(SettingsController( maintenanceNotificationService));
    return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _ReminderPeriodSection(),
                  SizedBox(height: ConsSize.space),
                  _GraphPeriodSection(),
                  SizedBox(height: ConsSize.space),
                  CustomButton(
                    title: "Kaydet",
                    callback: () async{
                     await viewModel.save();
                     Get.to(HomeView());
                    },
                  ),
                ],
              ),
            );
  }
}
