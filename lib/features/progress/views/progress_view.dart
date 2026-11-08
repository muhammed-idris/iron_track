import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/progress/views/alltime_page.dart';
import 'package:iron_track/features/progress/views/month_page.dart';
import 'package:iron_track/features/progress/views/week_page.dart';
import '../../../shared/customs/custom_animate.dart';
import '../widget/progress_app_bar.dart';
import '../widget/time_range.dart';

class ProgView extends StatefulWidget {
  const ProgView({super.key});

  @override
  State<ProgView> createState() => _ProgViewState();
}

class _ProgViewState extends State<ProgView> {
  late final PageController _pageController;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTimeRangeChanged(int index) {
    setState(() {
      selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const ProgressAppBar(title: 'Progress'),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.01,
        ),
        child: Column(
          children: [
            Gap(height * 0.02),
            TimeRangeSelector(
              selectedIndex: selectedIndex,
              onChanged: _onTimeRangeChanged,
            ),

            Gap(height * 0.025),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [WeekPage(), MonthPage(), AllTimePage()],
              )
            ),
          ],
        ),
      ).slideUp(
      delay: 10.ms,
      duration: 700.ms,
      curve: Curves.easeInOut,
      begin: 0.009,
      end: 0.0,
    ),
    );
  }
}
