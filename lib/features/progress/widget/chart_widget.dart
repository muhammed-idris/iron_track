import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';

final _defaultSpots = <FlSpot>[
  for (final (i, v) in [
    32000,
    41000,
    51000,
    62000,
    53000,
    49000,
    63000,
    76000,
    68000,
    58000,
    71000,
  ].indexed)
    FlSpot(1 + i * 2.9, v.toDouble()),
];

const _defaultXLabels = {
  1: 'Apr 1',
  8: 'Apr 8',
  15: 'Apr 15',
  22: 'Apr 22',
  30: 'Apr 30',
};

class VolumeChart extends StatelessWidget {
  const VolumeChart({
    super.key,
    this.title = 'Total Volume',
    this.totalVolumeLabel = '68,420 kg',
    this.spots,
    this.xLabels,
  });

  final String title;
  final String totalVolumeLabel;
  final List<FlSpot>? spots;
  final Map<int, String>? xLabels;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    final resolvedSpots = spots ?? _defaultSpots;
    final resolvedLabels = xLabels ?? _defaultXLabels;

    return CustomGlassCard(
      shadow: [
        BoxShadow(
          color: glass.shadowColor,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
      borderColors: glass.borderColors,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: glass.exerciseBackground,
      ),
      blur: 15,
      margin: EdgeInsets.zero,
      width: double.infinity,
      height: height * .35,
      padding: EdgeInsets.symmetric(
        horizontal: width * .05,
        vertical: height * .02,
      ),
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: glass.redButton.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: AppColor.primary,
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: context.text.bodySmall.copyWith(
                        color: glass.hintText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      totalVolumeLabel,
                      style: context.text.subtitle.copyWith(
                        color: glass.textMuted,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => glass.unSelectedColor,
                    tooltipBorderRadius: BorderRadius.circular(10),
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          spot.y.toStringAsFixed(1),
                          context.text.bodySmall.copyWith(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                minX: 1,
                maxX: 30,
                minY: 0,
                maxY: 100000,
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: 25000,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: Colors.white.withValues(alpha: 0.06),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 25000,
                      getTitlesWidget: (value, meta) => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value == 0 ? '0' : '${(value / 1000).round()}k',
                          style: context.text.bodySmall.copyWith(
                            color: glass.hintText,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 0.5,
                      getTitlesWidget: (value, meta) {
                        final label = resolvedLabels[value.round()];
                        if (label == null || value != value.roundToDouble()) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            label,
                            style: context.text.subtitle.copyWith(
                              color: glass.hintText,
                              fontSize: 9,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: resolvedSpots,
                    isCurved: true,
                    curveSmoothness: 0.25,
                    preventCurveOverShooting: true,
                    color: glass.redButton,
                    barWidth: 2.5,
                    dotData: FlDotData(
                      getDotPainter: (spot, percent, bar, index) {
                        return FlDotCirclePainter(
                          radius: 3,
                          color: glass.redButton,
                          strokeWidth: 1.5,
                          strokeColor: glass.textMuted,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          glass.redButton.withValues(alpha: 0.45),
                          glass.redButton.withValues(alpha: 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
