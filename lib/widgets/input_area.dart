import 'package:altur/constants/cons_padding.dart';
import 'package:altur/constants/cons_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputArea extends StatelessWidget {
  const InputArea({super.key, required this.title, required this.controller, this.keyboardType , this.inputFormatters, this.readOnly = false});
  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ConsPadding.inputPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleSmall!.copyWith(
              color: Colors.black45,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: ConsSize.space/4),
          TextFormField(
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            readOnly: readOnly,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.red.shade100,
                  width: 1,
                ),
              ),
              contentPadding: const ConsPadding.contentPadding(),
            ),
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '** $title Giriniz';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}