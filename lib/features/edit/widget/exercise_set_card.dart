import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../core/constants/app_theme_extension.dart';
import '../../../shared/containers/crystal_container.dart';
import '../../../shared/containers/gradient_container.dart';

class ExerciseSetCard extends StatelessWidget {
  const ExerciseSetCard({
    super.key,
    required this.index,
    required this.reps,
    required this.weight,
    required this.onDelete,
    this.width,
    this.height,
    this.glass,
  });

  final int index;
  final int reps;
  final double weight;
  final VoidCallback onDelete;
  final double? width;
  final double? height;
  final GlassTheme? glass;

  static String formatWeight(double w) =>
      w == w.roundToDouble() ? w.toInt().toString() : w.toString();

  @override
  Widget build(BuildContext context) {
    final resolvedWidth = width ?? MediaQuery.sizeOf(context).width;
    final resolvedGlass = glass ?? context.glass;
    final dividerStyle = context.text.appBar.copyWith(
      color: resolvedGlass.mutedBorder,
    );
    final valueStyle = context.text.appBar.copyWith(
      color: resolvedGlass.textPrimary,
    );

    return Slidable(
      key: ValueKey('set_slidable_$index'),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (_) => onDelete(),
            backgroundColor: AppColor.danger,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: CustomGlassCard(
        shadow: [
          BoxShadow(
            color: resolvedGlass.shadowColor,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
        blur: 5,
        margin: EdgeInsets.zero,
        borderRadius: 20,
        borderColors: resolvedGlass.borderColors,
        gradient: LinearGradient(colors: resolvedGlass.exerciseBackground),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientContainer(
              width: resolvedWidth * 0.09,
              height: resolvedWidth * 0.085,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              borderRadius: 15,
              colors: resolvedGlass.selectedDay,
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: context.text.headline2.copyWith(color: AppColor.white),
                ),
              ),
            ),
            Gap(resolvedWidth * 0.04),
            Text('|', style: dividerStyle),
            Expanded(
              child: _MetricCell(
                value: reps.toString(),
                label: 'Reps',
                style: valueStyle,
                labelColor: resolvedGlass.textMuted,
              ),
            ),
            Text('|', style: dividerStyle),
            Expanded(
              flex: 2,
              child: _MetricCell(
                value: formatWeight(weight),
                label: 'Weight',
                style: valueStyle,
                labelColor: resolvedGlass.textMuted,
              ),
            ),
            Icon(
              Icons.edit_rounded,
              size: 16,
              color: resolvedGlass.textMuted,
            ),
            const Gap(4),
          ],
        ),
      ),
    );
  }
}

class _MetricCell extends StatelessWidget {
  const _MetricCell({
    required this.value,
    required this.label,
    required this.style,
    required this.labelColor,
  });

  final String value;
  final String label;
  final TextStyle style;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value, maxLines: 1, style: style),
          ),
          Text(
            label,
            style: TextStyle(color: labelColor, fontSize: 10),
          ),
        ],
      ),
    );
  }
}