import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../core/constants/app_theme_extension.dart';
import '../../../core/constants/text_styles.dart';
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

  @override
  Widget build(BuildContext context) {
    final resolvedWidth = width ?? MediaQuery.sizeOf(context).width;
    final resolvedGlass = glass ?? context.glass;
    final dividerStyle = TextStyles.appBar.copyWith(
      color: resolvedGlass.mutedBorder,
    );
    final valueStyle = TextStyles.appBar.copyWith(
      color: resolvedGlass.textPrimary,
    );

    return Slidable(
      key: ValueKey('set_slidable_$index'),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 1,
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (_) => onDelete(),
            backgroundColor: AppColor.danger,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Press To Delete',
            borderRadius: BorderRadius.circular(20),
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
        gradient: LinearGradient(
          colors: resolvedGlass.exerciseBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  style: TextStyles.headline2,
                ),
              ),
            ),
            Gap(resolvedWidth * 0.05),
            Text('|', style: dividerStyle),
            Gap(resolvedWidth * 0.02),
            _ScrollableMetricCell(
              width: resolvedWidth * 0.14,
              value: reps.toString(),
              style: valueStyle,
            ),
            Gap(resolvedWidth * 0.02),
            Text('|', style: dividerStyle),
            Gap(resolvedWidth * 0.03),
            _ScrollableMetricCell(
              width: resolvedWidth * 0.27,
              value: weight.toString(),
              style: valueStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrollableMetricCell extends StatelessWidget {
  const _ScrollableMetricCell({
    required this.width,
    required this.value,
    required this.style,
  });

  final double width;
  final String value;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Text(value, style: style),
        ),
      ),
    );
  }
}
