import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:iron_track/shared/customs/custom_app_bar.dart';

import '../../../core/constants/app_theme_extension.dart';
import '../../../core/theme/theme_context.dart';

class ExerciseTitleHeader extends StatelessWidget {
  const ExerciseTitleHeader({
    super.key,
    required this.title,
    required this.glass,
    this.setsCount = 0,
    this.totalVolume = 0,
  });

  final String title;
  final GlassTheme glass;
  final int setsCount;
  final double totalVolume;

  static String _fmt(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final topInset = MediaQuery.paddingOf(context).top;

    return CustomGlassCard(
      gradient: LinearGradient(colors: glass.accentSurfaceGradient),
      margin: EdgeInsets.zero,
      padding: EdgeInsets.only(top: topInset + 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(appBarTitle: 'Edit Workout Screen'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exercise Name',
                  style: context.text.appBarTitle.copyWith(
                    color: glass.textMuted,
                    fontSize: 12,
                  ),
                ),
                const Gap(4),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    title.toUpperCase(),
                    maxLines: 1,
                    style: context.text.appBarTitle.copyWith(
                      color: glass.textPrimary,
                    ),
                  ),
                ),
                const Gap(12),
                Row(
                  children: [
                    _StatChip(
                      icon: Icons.layers_rounded,
                      label: '$setsCount sets',
                      glass: glass,
                    ),
                    const Gap(8),
                    _StatChip(
                      icon: Icons.bar_chart_rounded,
                      label: '${_fmt(totalVolume)} vol',
                      glass: glass,
                    ),
                  ],
                ),
                const Gap(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.glass,
  });

  final IconData icon;
  final String label;
  final GlassTheme glass;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: glass.textPrimary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: glass.textMuted),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: glass.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}