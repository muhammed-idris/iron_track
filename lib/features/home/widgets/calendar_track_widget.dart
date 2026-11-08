import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';
import 'month_calender.dart';

class CalendarTrackWidget extends StatefulWidget {
  final Set<DateTime> trainedDates;

  const CalendarTrackWidget({super.key, this.trainedDates = const {}});

  @override
  State<CalendarTrackWidget> createState() => _CalendarTrackWidgetState();
}

class _CalendarTrackWidgetState extends State<CalendarTrackWidget> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    final yearTotal =
        widget.trainedDates.where((d) => d.year == _month.year).length;
    final startWindow = DateTime(_month.year, _month.month - 1);

    return CustomGlassCard(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
      blur: 15,
      margin: EdgeInsets.zero,
      borderGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: glass.accentSurfaceGradient,
      ),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: glass.accentSurfaceGradient,
      ),
      borderRadius: 25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomGlassCard(
                borderRadius: 30,
                padding: EdgeInsets.all(height * 0.01),
                gradient: LinearGradient(colors: glass.softBadgeGradient),
                child: Image.asset(
                  'assets/icons/calendar-alt.png',
                  height: height * 0.025,
                  fit: BoxFit.cover,
                  color: glass.textMuted,
                ),
              ),
              Gap(width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_month.year}',
                      style: TextStyles.numbers.copyWith(
                        color: glass.textPrimary,
                      ),
                    ),
                    Gap(height * 0.005),
                    Text(
                      'One square per day, lit on the days you trained',
                      style: TextStyles.badge.copyWith(color: glass.hintText),
                    ),
                  ],
                ),
              ),
              Gap(width * 0.02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$yearTotal',
                    style: TextStyles.numbers.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                  Gap(width * 0.005),
                  Text(
                    'days',
                    style: TextStyles.badge.copyWith(color: glass.hintText),
                  ),
                ],
              ),
            ],
          ),
          Gap(height * 0.01),
          MonthCalendarGroup(
            startYear: startWindow.year,
            startMonth: startWindow.month,
            count: 3,
            trainedDates: widget.trainedDates,
          ),
        ],
      ),
    );
  }
}
