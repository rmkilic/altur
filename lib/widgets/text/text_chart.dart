import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextChart extends StatelessWidget {
  const TextChart({super.key, required this.text, this.color, this.fontWeight = FontWeight.w400});
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodySmall!
          .copyWith(fontWeight: fontWeight, color: color),
    );
  }
}