import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/home/data/exercise_model.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:iron_track/shared/containers/gradient_container.dart';
import '../../../../core/constants/colors_manager.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../home/widgets/delete_widget.dart';

class ExerciseDataWidget extends StatelessWidget {
  const ExerciseDataWidget({
    super.key,
    required this.exercise,
    required this.exeNumber,
    this.onDelete,
  });

  final ExerciseModel exercise;
  final int exeNumber;
  final VoidCallback? onDelete;

  Future<void> _handleDelete(BuildContext context) async {
    final confirmed = await showDeleteConfirmationDialog(
      context,
      itemName: exercise.exerciseTitle ?? 'Exercise',
      title: 'Delete Exercise?',
    );
    if (confirmed == true) onDelete?.call();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    return RepaintBoundary(
      child: Slidable(
        key: ValueKey('exercise_slidable_${exercise.id ?? exeNumber}'),
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              flex: 1,
              onPressed: _handleDelete,
              backgroundColor: AppColor.danger,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(5),
            ),
            SlidableAction(
              flex: 1,
              onPressed: _handleDelete,
              backgroundColor: AppColor.grey700,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
        child: CustomGlassCard(
          shadow: [
            BoxShadow(
              color: glass.shadowColor,
              blurRadius: 0.1,
              offset: const Offset(0, 1),
            ),
          ],
          margin: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.025,
            vertical: height * 0.015,
          ),
          blur: 0,
          borderGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: glass.borderColors,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: glass.exerciseBackground,
          ),
          borderRadius: 20,
          width: width * 0.95,
          child: Row(
            children: [
              GradientContainer(
                width: width * 0.08,
                height: width * 0.09,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                borderRadius: 10,
                colors: glass.selectedDay,
                child: Center(
                  child: Text('$exeNumber', style: TextStyles.headline2),
                ),
              ),
              Gap(width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.exerciseTitle ?? '',
                      style: TextStyles.headline1.copyWith(
                        color: glass.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(height * 0.01),
                    Text(
                      'Sets ${exercise.setsCount ?? 0}',
                      style: TextStyles.bodySmall.copyWith(
                        color: glass.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: glass.textPrimary.withValues(alpha: 0.35),
                size: width * 0.05,
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
