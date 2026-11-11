import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/home/widgets/levels_widget.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import '../../edit/widget/workout_app_bar.dart';

class LevelsView extends StatelessWidget {
  final double volumeXp;

  const LevelsView({super.key, required this.volumeXp});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    return Scaffold(
      appBar: const WorkoutAppBar(appBarTitle: 'All Levels'),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        itemCount: levelTiers.length,
        itemBuilder: (context, index) {
          final tier = levelTiers[index];
          final level = tier['level'] as int;
          final name = tier['name'] as String;
          final minXp = (tier['minXp'] as num).toDouble();
          final maxXp = (tier['maxXp'] as num).toDouble();
          final badgeAsset = tier['badgeAsset'] as String;

          final isCompleted = volumeXp >= maxXp;
          final isCurrent = volumeXp >= minXp && volumeXp < maxXp;
          final isLocked = !isCompleted && !isCurrent;

          final progress = isCompleted
              ? 1.0
              : isCurrent
                  ? ((volumeXp - minXp) / (maxXp - minXp)).clamp(0.0, 1.0)
                  : 0.0;

          final displayXp = isCompleted
              ? maxXp
              : isCurrent
                  ? volumeXp
                  : minXp;

          return Padding(
            padding: EdgeInsets.only(bottom: height * 0.01),
            child: _LevelTimelineRow(
              isFirst: index == 0,
              isLast: index == levelTiers.length - 1,
              isCompleted: isCompleted,
              isCurrent: isCurrent,
              isLocked: isLocked,
              child: CustomGlassCard(
                borderRadius: 15,
                margin: EdgeInsets.zero,
                gradient: LinearGradient(
                  colors: isCurrent
                      ? glass.accentSurfaceGradient
                      : glass.exerciseBackground,
                ),
                borderColor: isCurrent
                    ? AppColor.primary1
                    : glass.accentSurfaceBorder,
                borderWidth: isCurrent ? 1.5 : 1,
                child: Opacity(
                  opacity: isLocked ? 0.5 : 1,
                  child: Row(
                    children: [
                      Image.asset(
                        badgeAsset,
                        width: width * 0.15,
                        height: height * 0.07,
                        fit: BoxFit.contain,
                      ),
                      Gap(width * 0.02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: context.text.headline1.copyWith(
                                color: isLocked
                                    ? glass.textMuted
                                    : glass.textPrimary,
                              ),
                            ),
                            Text(
                              'Level $level',
                              style: context.text.body.copyWith(
                                color: glass.hintText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 5,
                                backgroundColor: glass.mutedBorder,
                                color: isLocked
                                    ? glass.textMuted
                                    : AppColor.primary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${displayXp.toStringAsFixed(0)} / ${maxXp.toStringAsFixed(0)}',
                              style: context.text.body.copyWith(
                                color: glass.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LevelTimelineRow extends StatelessWidget {
  const _LevelTimelineRow({
    required this.isFirst,
    required this.isLast,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLocked,
    required this.child,
  });

  final bool isFirst;
  final bool isLast;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLocked;
  final Widget child;

  static const double _dotSize = 14;
  static const double _lineWidth = 2;
  static const double _railWidth = 28;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final width = MediaQuery.sizeOf(context).width;

    final aboveColor = isFirst
        ? Colors.transparent
        : ((isCompleted || isCurrent) ? AppColor.primary : glass.mutedBorder);

    final belowColor = isLast
        ? Colors.transparent
        : (isCompleted ? AppColor.primary : glass.mutedBorder);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _railWidth,
            child: Column(
              children: [
                Expanded(
                  child: Container(width: _lineWidth, color: aboveColor),
                ),
                Container(
                  width: _dotSize,
                  height: _dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent ? AppColor.primary : Colors.transparent,
                    border: Border.all(
                      color: isLocked ? glass.mutedBorder : AppColor.primary,
                      width: 2,
                    ),
                    boxShadow: isCurrent
                        ? const [
                            BoxShadow(
                              color: AppColor.primary,
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                ),
                Expanded(
                  child: Container(width: _lineWidth, color: belowColor),
                ),
              ],
            ),
          ),
          Gap(width * 0.02),
          Expanded(child: child),
        ],
      ),
    );
  }
}
