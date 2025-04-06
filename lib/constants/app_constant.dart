import 'package:altur/utils/keyboard_input/index.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class AppConstants {
  static String hiveBoxName = 'settings';
  static String localDbName = 'altur_case.db';
  //Keyboard Input Format
  static List<TextInputFormatter> get upperCharacterFormatter => [UpperCharacterFormatter()];
  static List<TextInputFormatter> get upperWordFormatter => [UpperWordFormatter()];

  static DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  static DateFormat dateFormatDayMonth = DateFormat('dd/MM');

  //https://www.schemecolor.com/stunning-pie-chart-color-scheme.php
  static List<Color> pieColorList = [
    Color(0xFFEA5F89),
    Color(0xFF9B3192),
    Color(0xFF57167E),
    Color(0xFF2B0B3F),
  ];

}