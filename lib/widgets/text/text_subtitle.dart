import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextSubtitle extends StatelessWidget {
  const TextSubtitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
                    text,
                    style: context.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  );
  }
}