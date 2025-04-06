import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.titleLarge,),
        Divider(),
      ],
    );
  }
}