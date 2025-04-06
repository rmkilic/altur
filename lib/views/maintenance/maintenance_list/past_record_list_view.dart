
import 'package:altur/constants/app_constant.dart';
import 'package:altur/constants/cons_padding.dart';
import 'package:altur/constants/cons_size.dart';
import 'package:altur/view_models/maintenance_view_model.dart';
import 'package:altur/views/maintenance/maintenance_list/widgets/pie_chart.dart';
import 'package:altur/widgets/page_title.dart';
import 'package:altur/widgets/text/text_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastRecordListView extends StatelessWidget {
  final maintenanceViewModel = Get.find<MaintenanceViewModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      
      return body(context);
    });
  }

  body(BuildContext context)
  {
    return Padding(
        padding: const ConsPadding.itemMargin(),
        child: Column(
          children: [
            PageTitle(title: "Geçmiş Bakımlar"),
            content(context)
          ],
        ),
      );
  }

  content(BuildContext context)
  {
    if (maintenanceViewModel.pastRecords.isEmpty) {
        return Center(child: TextBody(text:'Bakım Kaydı Bulunamadı'));
      }
      else
      {
        return Expanded(
          child: Column(
            
                children: [
                  SizedBox(
                        height: 300,
                        width: context.width,
                        child: PieChartWidget(
                          dataMap: getGroupedData(),
                        ),
                      ),
                      SizedBox(height: ConsSize.space,),
                      Expanded(
                        child: ListView.builder(
                          itemCount: maintenanceViewModel.pastRecords.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const ConsPadding.itemMargin(),
                                child: ListTile(
                                  title: Text(maintenanceViewModel.pastRecords[index].type),
                                  subtitle: Text('Tarih: ${AppConstants.dateFormat.format(maintenanceViewModel.pastRecords[index].date)}\nMaliyet: ${maintenanceViewModel.pastRecords[index].cost} ₺'),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                ],
              ),
        );
      }
   
  }

  Map<String, double> getGroupedData() {
    Map<String, double> dataMap = {};
    for (var record in maintenanceViewModel.pastRecords) {
      if (dataMap.containsKey(record.type)) {
        dataMap[record.type] = dataMap[record.type]! + record.cost;
      } else {
        dataMap[record.type] = record.cost;
      }
    }
    return dataMap;
  }
}