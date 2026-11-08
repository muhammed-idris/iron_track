import 'package:flutter/material.dart';
import '../widget/chart_widget.dart';

class MonthPage extends StatelessWidget {
  const MonthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          VolumeChart(
            title: 'Monthly Volume',
            totalVolumeLabel: '248,600 kg',
          ),
        ],
      ),
    );
  }
}
