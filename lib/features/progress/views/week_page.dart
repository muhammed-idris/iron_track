import 'package:flutter/material.dart';
import '../../../core/theme/theme_context.dart';
import '../widget/chart_widget.dart';

class WeekPage extends StatelessWidget {
  const WeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
           const VolumeChart(),
        ],
      ),
    );
  }
}
