import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/theme/theme_context.dart';


class MonthCalendarGroup extends StatelessWidget {
  final int startYear;
  final int startMonth;
  final int count;
  final Set<DateTime> trainedDates;
  final double spacing;
  final double monthGap;

  const MonthCalendarGroup({
    super.key,
    required this.startYear,
    required this.startMonth,
    this.count = 3,
    this.trainedDates = const {},
    this.spacing = 3,
    this.monthGap = 16,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final monthWidth =
            (constraints.maxWidth - monthGap * (count - 1)) / count;
        final cellSize = ((monthWidth - spacing * 6) / 7).floorToDouble();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < count; i++)
              Builder(builder: (context) {
                final date = DateTime(startYear, startMonth + i);
                final days = trainedDates
                    .where((d) => d.year == date.year && d.month == date.month)
                    .map((d) => d.day)
                    .toSet();
                return MonthCalendar(
                  year: date.year,
                  month: date.month,
                  trainedDays: days,
                  cellSize: cellSize,
                  spacing: spacing,
                );
              }),
          ],
        );
      },
    );
  }
}

class MonthCalendar extends StatelessWidget {
  final int year;
  final int month;
  final Set<int> trainedDays;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  final double cellSize;
  final double spacing;

  const MonthCalendar({
    super.key,
    required this.year,
    required this.month,
    this.trainedDays = const {},
    this.onPrevious,
    this.onNext,
    this.cellSize = 24,
    this.spacing = 6,
  });

  static const _monthNames = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
  ];

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final height = MediaQuery.of(context).size.height;

    final daysInMonth = DateTime(year, month + 1, 0).day;
    final leadingBlanks = (DateTime(year, month, 1).weekday - 1) % 7;
    final gridWidth = cellSize * 7 + spacing * 6;

    return SizedBox(
      width: gridWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _monthNames[month - 1],
                style: TextStyles.body.copyWith(color: glass.textPrimary),
              ),
              Text(
                trainedDays.length.toString(),
                style: TextStyles.body.copyWith(color: glass.textMuted),
              ),
            ],
          ),
          Gap(height * 0.005),
          Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (var i = 0; i < leadingBlanks; i++)
                SizedBox(width: cellSize, height: cellSize),
              for (var day = 1; day <= daysInMonth; day++)
                Container(
                  width: cellSize,
                  height: cellSize,
                  decoration: BoxDecoration(
                    color: trainedDays.contains(day)
                        ? AppColor.primary
                        : glass.buttonColor,
                    borderRadius: BorderRadius.circular(cellSize * 0.2),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}