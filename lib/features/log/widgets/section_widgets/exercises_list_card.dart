import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/features/home/data/exercise_model.dart';
import '../../../../core/constants/colors_manager.dart';
import '../../../../shared/containers/crystal_container.dart';
import '../../../edit/view/edit_exercise_screen.dart';
import '../../../home/logic/iron_track_helper.dart';
import '../../views/add_exercise_screen.dart';
import 'exercise_data_widget.dart';

class ExerciseListHeader extends StatelessWidget {
  final int count;
  final String selectedDayName;
  final VoidCallback onExerciseCreated;

  const ExerciseListHeader({
    super.key,
    required this.count,
    required this.selectedDayName,
    required this.onExerciseCreated,
  });

  String _label(int n) => n == 1 ? 'Exercise' : 'Exercises';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final glass = context.glass;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomGlassCard(
          gradient: LinearGradient(colors: glass.softBadgeGradient),
          width: width * 0.08,
          height: height * 0.035,
          borderRadius: 50,
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Text(
                "$count",
                key: ValueKey(count),
                style: context.text.headline1.copyWith(color: glass.textMuted),
              ),
            ),
          ),
        ),
        const Gap(7),
        Text(
          _label(count),
          style: context.text.headline1.copyWith(color: glass.textPrimary),
        ),
        const Spacer(),
        _AddButton(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddExerciseScreen(
                selectedDay: selectedDayName,
                onExerciseCreated: onExerciseCreated,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddButton extends StatefulWidget {
  final VoidCallback onTap;

  const _AddButton({required this.onTap});

  @override
  State<_AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<_AddButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        HapticFeedback.lightImpact();
        setState(() => _pressed = true);
      },
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: CustomGlassCard(
          shadow: [
            BoxShadow(
              color: glass.shadowColor,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.zero,
          backgroundColor: glass.redButton,
          borderRadius: 12,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(CupertinoIcons.add, color: AppColor.white, size: 17),
              const Gap(5),
              Text("Add Exercise", style: context.text.buttonSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseListLoading extends StatelessWidget {
  const ExerciseListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CupertinoActivityIndicator(
            color: AppColor.primary,
            radius: 15,
          ),
        ),
      ),
    );
  }
}

class ExerciseListEmpty extends StatelessWidget {
  const ExerciseListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final glass = context.glass;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              "assets/images/no exe.png",
              height: height * 0.2,
              width: width * 0.7,
              fit: BoxFit.cover,
            ),
            Gap(height * 0.01),
            Text(
              "No exercises yet ",
              textAlign: TextAlign.center,
              style: context.text.appBar.copyWith(color: glass.textPrimary),
            ),
            Gap(height * 0.005),
            Text(
              "Tap the Add Exercise Button to get started\n and build your workout.   ",
              textAlign: TextAlign.center,
              style: context.text.headline2.copyWith(color: glass.hintText),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

class ExerciseListItem extends StatelessWidget {
  final ExerciseModel exercise;
  final int index;
  final ValueChanged<ExerciseModel> onDelete;
  final ValueChanged<ExerciseModel> onUpdate;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.index,
    required this.onDelete,
    required this.onUpdate,
  });

  Future<void> _openEditScreen(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditExerciseScreen(
          exercise: exercise,
          exeNumber: index + 1,
          onDelete: () async {
            await IronTrackHelper.delete(exercise.id!);
            onDelete(exercise);
            if (context.mounted) Navigator.pop(context);
          },
          onUpdate: (updated) async {
            await IronTrackHelper.update(updated);
            onUpdate(updated);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child:
          GestureDetector(
                onTap: () => _openEditScreen(context),
                child: ExerciseDataWidget(
                  exercise: exercise,
                  exeNumber: index + 1,
                  onDelete: () async {
                    await IronTrackHelper.delete(exercise.id!);
                    onDelete(exercise);
                  },
                ),
              )
              .animate()
              .slideY(
                delay: (60 * index).ms,
                duration: 450.ms,
                curve: Curves.easeOutCubic,
                begin: 0.05,
                end: 0.0,
              )
              .fadeIn(delay: (60 * index).ms, duration: 350.ms),
    );
  }
}
