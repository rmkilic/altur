import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextBody extends StatelessWidget {
  const TextBody({super.key, required this.text, this.color, this.fontWeight = FontWeight.w400});
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodyMedium!
          .copyWith(fontWeight: fontWeight, color: color),
    );
  }
}