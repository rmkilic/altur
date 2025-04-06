import 'package:flutter/services.dart';
import 'package:turkish/turkish.dart';

class UpperWordFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    String text = newValue.text;
    String capitalizedText = text[0].toUpperCaseTr() + text.substring(1).toLowerCaseTr();
    return TextEditingValue(
      text: capitalizedText,
      selection: newValue.selection,
    );
  }
}