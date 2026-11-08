import 'package:flutter/material.dart';
import '../widget/chart_widget.dart';

class AllTimePage extends StatelessWidget {
  const AllTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          VolumeChart(
            title: 'All-Time Volume',
            totalVolumeLabel: '1,420,800 kg',
          ),
        ],
      ),
    );
  }
}
