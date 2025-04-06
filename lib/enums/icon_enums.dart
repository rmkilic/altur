import 'package:flutter/material.dart';

enum IconEnums
{
  expand(icon: Icons.keyboard_arrow_down),
  calendar(icon:Icons.date_range),
  add(icon: Icons.add),
  getMore(icon: Icons.double_arrow_outlined);
  const IconEnums({
    required this.icon
  });
  final IconData icon;
}

extension IconExtension on IconEnums
{
    Widget get iconWidget => Icon(icon, color: Colors.black45,);
}