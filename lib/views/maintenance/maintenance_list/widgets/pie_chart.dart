/* import 'package:altur/constant/app_constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> dataMap;

  PieChartWidget({required this.dataMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PieChart(
        PieChartData(
          sections: dataMap.entries.map((entry) {
          int index = dataMap.keys.toList().indexOf(entry.key);
          int colorLength = AppConstants.pieColorList.length;
          int activeIndex = index == 0 ? 0 :  (index % (colorLength -1));
            return PieChartSectionData(
              value: entry.value,
              title: entry.key,
              color: AppConstants.pieColorList[activeIndex],
              radius: 100,  // Adjust the radius for a filled look
              titleStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
          sectionsSpace: 5,  // No space between sections
          centerSpaceRadius: 0,  // No space in the center
        ),
      ),
    );
  }
} */
/* import 'package:altur/constant/app_constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> dataMap;

  PieChartWidget({required this.dataMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PieChart(
        PieChartData(
          sections: dataMap.entries.map((entry) {
            int index = dataMap.keys.toList().indexOf(entry.key);
            int colorLength = AppConstants.pieColorList.length;
            int activeIndex = index == 0 ? 0 : (index % (colorLength - 1));
            double percentage = (entry.value / dataMap.values.reduce((a, b) => a + b)) * 100;
            
            return PieChartSectionData(
              value: entry.value,
              title: percentage < 5 ? '' : '${entry.key}\n${percentage.toStringAsFixed(1)}%',
              color: AppConstants.pieColorList[activeIndex],
              radius: 100,  // Adjust the radius for a filled look
              titleStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              badgeWidget: percentage < 5
                  ? Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.pieColorList[activeIndex],
                      ),
                    )
                  : null,
              badgePositionPercentageOffset: 1.2,
            );
          }).toList(),
          sectionsSpace: 5,  // No space between sections
          centerSpaceRadius: 0,  // No space in the center
        ),
      ),
    );
  }
} */
import 'package:altur/constants/app_constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> dataMap;

  PieChartWidget({required this.dataMap});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: dataMap.entries.map((entry) {
          int index = dataMap.keys.toList().indexOf(entry.key);
          int colorLength = AppConstants.pieColorList.length;
          int activeIndex = index == 0 ? 0 : (index % colorLength);
          double percentage = (entry.value / dataMap.values.reduce((a, b) => a + b)) * 100;
    
          return PieChartSectionData(
            value: entry.value,
            title: percentage >= 5 ? '${percentage.toStringAsFixed(1)}%' : '',
            color: AppConstants.pieColorList[activeIndex],
            radius: 100,  // Adjust the radius for a filled look
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget:  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ,
            badgePositionPercentageOffset: 1.2,
          );
        }).toList(),
        sectionsSpace: 2,  // Space between sections
        centerSpaceRadius: 40,  // Space in the center
      ),
    );
  }
}