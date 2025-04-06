import 'package:altur/constants/cons_size.dart';
import 'package:flutter/material.dart';

class DayAnimation extends StatelessWidget {
  const DayAnimation({
    super.key,
    required this.differenceInDays,
    required this.period,
    required this.indicatorColor,
  });

  final int differenceInDays;
  final int period;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
      tween: Tween<double>(
        begin: 0,
        end: differenceInDays / period,
      ),
      builder: (context, value, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            minHeight: ConsSize.space/2,
            backgroundColor: indicatorColor.withValues(alpha: .3),
            color: indicatorColor,
          ),
        );
      },
    );
  }
}