import 'package:altur/constants/app_constant.dart';
import 'package:altur/constants/cons_padding.dart';
import 'package:altur/constants/cons_size.dart';
import 'package:altur/data/models/maintenance_record.dart';
import 'package:altur/view_models/maintenance_add_viewmodel.dart';
import 'package:altur/widgets/common_appbar.dart';
import 'package:altur/widgets/custom_button.dart';
import 'package:altur/widgets/custom_date_picker.dart';
import 'package:altur/widgets/input_area.dart';
import 'package:altur/widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MaintenanceAddView extends StatefulWidget {
  final int vehicleId;
  final MaintenanceRecord? maintenance;

  const MaintenanceAddView({super.key, 
    required this.vehicleId,
    this.maintenance,
  });

  @override
  State<MaintenanceAddView> createState() => _MaintenanceAddViewState();
}

class _MaintenanceAddViewState extends State<MaintenanceAddView> {
  late MaintenanceRecordFormViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Get.put(
      MaintenanceRecordFormViewModel(
        vehicleId: widget.vehicleId,
        maintenance: widget.maintenance,
      ),
      tag: widget.maintenance?.id?.toString() ?? UniqueKey().toString(), // benzersiz tag
    );
  }

  @override
  void dispose() {
    Get.delete<MaintenanceRecordFormViewModel>(
      tag: widget.maintenance?.id?.toString() ?? '',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: Padding(
        padding: const ConsPadding.itemMargin(),
        child: Column(
          children: [
            Obx(() => PageTitle(title: viewModel.isInfo.value ? "Bakım Detayı" : "Yeni Bakım")),
            _form(),
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(() => CustomDatePickerFormField(
                    enabled: viewModel.isInfo.value,
                    controller: viewModel.dateController,
                    labelText: 'Tarih',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen tarihi girin';
                      }
                      return null;
                    },
                  )),
              Obx(() => InputArea(
                    title: "Bakım Türü",
                    controller: viewModel.typeController,
                    inputFormatters: AppConstants.upperCharacterFormatter,
                    readOnly: viewModel.isInfo.value,
                  )),
              Obx(() => InputArea(
                    title: "Masraf",
                    controller: viewModel.costController,
                    keyboardType: TextInputType.numberWithOptions(),
                    readOnly: viewModel.isInfo.value,
                  )),
              Obx(() => InputArea(
                    title: "Kilometre",
                    controller: viewModel.mileageController,
                    keyboardType: TextInputType.number,
                    readOnly: viewModel.isInfo.value,
                  )),
              SizedBox(height: ConsSize.space),
              Obx(() => Visibility(
                    visible: !viewModel.isInfo.value,
                    child: CustomButton(
                      title: 'Kaydet',
                      callback: viewModel.onTapSave,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}