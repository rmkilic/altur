import 'package:altur/constants/app_constant.dart';
import 'package:altur/constants/cons_padding.dart';
import 'package:altur/enums/icon_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePickerFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomDatePickerFormField({super.key, 
    required this.controller,
    required this.labelText,
    this.validator,
    this.enabled = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ConsPadding.inputPadding(),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: IconEnums.calendar.iconWidget,
          hintText: labelText,
          hintStyle: context.textTheme.titleSmall!.copyWith(
              color: Colors.black45,
              fontWeight: FontWeight.w400,
            ),

          enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
        ),
        readOnly: true,
        onTap: enabled ? null : () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            String formattedDate = AppConstants.dateFormat.format(pickedDate);
            controller.text = formattedDate;
          }
        },
        validator: validator,
      ),
    );
  }
}