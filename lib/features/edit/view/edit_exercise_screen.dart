import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/app_theme_extension.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/home/data/exercise_model.dart';
import 'package:iron_track/shared/containers/crystal_container.dart';
import 'package:iron_track/shared/containers/info_divider.dart';
import 'package:iron_track/shared/customs/custom_btn.dart';

import '../../../core/constants/colors_manager.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../../home/widgets/delete_widget.dart';
import '../../log/widgets/workout_refresh_notifier.dart';
import '../data/set_model.dart';
import '../logic/set_helper.dart';
import '../widget/add_set_dialog.dart';
import '../widget/edit_set_container.dart';
import '../widget/exercise_set_card.dart';
import '../widget/workout_app_bar.dart';

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({
    super.key,
    required this.exercise,
    required this.exeNumber,
    this.onDelete,
    this.onUpdate,
    this.value,
  });

  final ExerciseModel exercise;
  final int exeNumber;
  final VoidCallback? onDelete;
  final Future<void> Function(ExerciseModel exercise)? onUpdate;
  final double? value;

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  static const int _maxReps = 1000;
  static const double _maxWeight = 100000;

  late final TextEditingController _exerciseNameController;
  late List<SetEntry> _setEntries;
  bool _loadingSetEntries = true;
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _exerciseNameController = TextEditingController(
      text: widget.exercise.exerciseTitle ?? '',
    );
    _setEntries = _buildFallbackSetEntries(widget.exercise);
    _loadSetEntries();
  }

  @override
  void dispose() {
    _exerciseNameController.dispose();
    super.dispose();
  }

  List<SetEntry> _buildFallbackSetEntries(ExerciseModel exercise) {
    final count = exercise.setsCount ?? 0;
    final exerciseId = exercise.id ?? -1;
    return List.generate(
      count,
      (i) => SetEntry(
        exerciseId: exerciseId,
        setIndex: i,
        reps: exercise.reps ?? 0,
        weight: exercise.weight ?? 0,
      ),
    );
  }

  List<SetEntry> _reindexSets(List<SetEntry> entries) {
    return List.generate(
      entries.length,
      (i) => entries[i].copyWith(setIndex: i),
    );
  }

  Future<void> _loadSetEntries() async {
    final exerciseId = widget.exercise.id;
    if (exerciseId == null) {
      if (mounted) setState(() => _loadingSetEntries = false);
      return;
    }

    final loaded = await SetEntryHelper.readByExercise(exerciseId);
    if (!mounted) return;

    setState(() {
      if (loaded.isNotEmpty) {
        _setEntries = loaded;
      }
      _loadingSetEntries = false;
    });
  }

  Future<void> _persistChanges() async {
    final exerciseId = widget.exercise.id;
    if (exerciseId == null) return;

    final title = _exerciseNameController.text.trim();
    final legacyReps = _setEntries.isNotEmpty
        ? _setEntries.last.reps
        : widget.exercise.reps;
    final legacyWeight = _setEntries.isNotEmpty
        ? _setEntries.last.weight
        : widget.exercise.weight;

    if (title.isNotEmpty && widget.onUpdate != null) {
      final updated = widget.exercise.copyWith(
        exerciseTitle: title,
        setsCount: _setEntries.length,
        reps: legacyReps,
        weight: legacyWeight,
      );

      final hasChanged =
          updated.exerciseTitle != widget.exercise.exerciseTitle ||
          updated.setsCount != widget.exercise.setsCount ||
          updated.reps != widget.exercise.reps ||
          updated.weight != widget.exercise.weight;

      if (hasChanged) {
        await widget.onUpdate!(updated);
      }
    }

    await SetEntryHelper.replaceForExercise(exerciseId, _setEntries);
    workoutRefreshNotifier.bump();
  }

  bool _isOutOfRange({required int newReps, required double newWeight}) {
    if (newReps > _maxReps) {
      AppSnackBar.error(
        context: context,
        message: 'Reps seems too high',
        duration: const Duration(seconds: 2),
      );
      return true;
    }
    if (newWeight > _maxWeight) {
      AppSnackBar.error(
        context: context,
        message: 'Weight seems too high',
        duration: const Duration(seconds: 2),
      );
      return true;
    }
    return false;
  }

  Future<void> _addSet() async {
    final confirmed = await showAddSetConfirmationDialog(context);
    if (!mounted || confirmed != true) return;

    final exerciseId = widget.exercise.id ?? -1;
    final lastReps = _setEntries.isNotEmpty
        ? _setEntries.last.reps
        : (widget.exercise.reps ?? 0);
    final lastWeight = _setEntries.isNotEmpty
        ? _setEntries.last.weight
        : (widget.exercise.weight ?? 0);

    final newEntry = SetEntry(
      exerciseId: exerciseId,
      setIndex: _setEntries.length,
      reps: lastReps,
      weight: lastWeight,
    );

    setState(() {
      _setEntries = _reindexSets([..._setEntries, newEntry]);
    });

    await _persistChanges();
    if (!mounted) return;

    AppSnackBar.success(
      context: context,
      message: 'Set added',
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _updateSet(int index, int reps, double weight) async {
    if (_isOutOfRange(newReps: reps, newWeight: weight)) return;

    setState(() {
      final updatedList = [..._setEntries];
      updatedList[index] = updatedList[index].copyWith(
        reps: reps,
        weight: weight,
      );
      _setEntries = updatedList;
      _expandedIndex = null;
    });

    await _persistChanges();
  }

  Future<void> _deleteSet(int index) async {
    final confirmed = await showDeleteConfirmationDialog(
      context,
      itemName: 'Set ${index + 1}',
      title: 'Delete Set?',
    );
    if (!mounted || confirmed != true) return;

    setState(() {
      final updatedList = [..._setEntries]..removeAt(index);
      _setEntries = _reindexSets(updatedList);

      if (_expandedIndex == index) {
        _expandedIndex = null;
      } else if (_expandedIndex != null && _expandedIndex! > index) {
        _expandedIndex = _expandedIndex! - 1;
      }
    });

    await _persistChanges();
    if (!mounted) return;

    AppSnackBar.success(
      context: context,
      message: 'Set deleted',
      duration: const Duration(seconds: 2),
    );
  }

  void _toggleExpand(int index) {
    setState(() {
      _expandedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          _persistChanges();
        }
      },
      child: SafeArea(
        top: true,
        child: Scaffold(
          appBar: const WorkoutAppBar(
            appBarTitle: 'Edit Workout Screen',
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: width * 0.04,
              right: width * 0.04,
              top: height * 0.02,
              bottom: height * 0.04,
            ),
            child: Column(
              children: [
                _ExerciseTitleHeader(
                  title: _exerciseNameController.text.trim(),
                  width: width,
                  height: height,
                  glass: glass,
                ),
                Gap(height * 0.02),
                _SetTableColumnsHeader(
                  width: width,
                  glass: glass,
                ),
                Gap(height * 0.01),
                Expanded(
                  child: _loadingSetEntries
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColor.primary,
                            radius: 15,
                          ),
                        )
                      : _ExerciseSetList(
                          entries: _setEntries,
                          expandedIndex: _expandedIndex,
                          width: width,
                          height: height,
                          glass: glass,
                          onSelectSet: _toggleExpand,
                          onSaveSet: _updateSet,
                          onDeleteSet: _deleteSet,
                        ),
                ),
                Gap(height * 0.015),
                CustomBtn(
                  borderRadius: 25,
                  height: height * 0.06,
                  text: 'Add Set',
                  icon: Icons.add_circle,
                  btnColors: [
                    AppColor.primary,
                    AppColor.primary.withValues(alpha: 0.8),
                  ],
                  animateIn: true,
                  onTap: _addSet,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExerciseTitleHeader extends StatelessWidget {
  const _ExerciseTitleHeader({
    required this.title,
    required this.width,
    required this.height,
    required this.glass,
  });

  final String title;
  final double width;
  final double height;
  final GlassTheme glass;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '|',
              style: context.text.appBarTitle.copyWith(
                color: glass.textMuted,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    title,
                    style: context.text.appBarTitle.copyWith(
                      color: glass.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(height * 0.01),
        InfoDivider(
          width: width,
          height: height * 0.005,
          color: glass.textMuted,
          margin: width * 0.02,
          topLeft: 20,
          topRight: 20,
          bottomLeft: 20,
          bottomRight: 20,
        ),
      ],
    );
  }
}

class _SetTableColumnsHeader extends StatelessWidget {
  const _SetTableColumnsHeader({
    required this.width,
    required this.glass,
  });

  final double width;
  final GlassTheme glass;

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.text.headline2.copyWith(color: glass.copyColor);
    final dividerStyle = context.text.appBar.copyWith(color: glass.mutedBorder);

    return Row(
      children: [
        Gap(width * 0.02),
        SizedBox(
          width: width * 0.15,
          child: Text('Type', style: labelStyle),
        ),
        Text('|', style: dividerStyle),
        Gap(width * 0.03),
        SizedBox(
          width: width * 0.14,
          child: Text('Reps', style: labelStyle),
        ),
        Text('|', style: dividerStyle),
        Gap(width * 0.02),
        Text('Weight', style: labelStyle),
        const Spacer(),
        CustomGlassCard(
          borderRadius: 10,
          width: width * 0.2,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(5),
          gradient: LinearGradient(colors: glass.softBadgeGradient),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                color: glass.textPrimary,
                size: 15,
              ),
              Gap(width * 0.01),
              Text(
                'Delete',
                style: context.text.subtitle.copyWith(
                  color: glass.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExerciseSetList extends StatelessWidget {
  const _ExerciseSetList({
    required this.entries,
    required this.expandedIndex,
    required this.width,
    required this.height,
    required this.glass,
    required this.onSelectSet,
    required this.onSaveSet,
    required this.onDeleteSet,
  });

  final List<SetEntry> entries;
  final int? expandedIndex;
  final double width;
  final double height;
  final GlassTheme glass;
  final ValueChanged<int> onSelectSet;
  final void Function(int index, int reps, double weight) onSaveSet;
  final ValueChanged<int> onDeleteSet;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final isExpanded = expandedIndex == index;

        return Padding(
          key: ObjectKey(entry),
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: GestureDetector(
            onTap: () => onSelectSet(index),
            child: isExpanded
                ? EditSetContainer(
                    reps: entry.reps,
                    weight: entry.weight,
                    onDone: (reps, weight) => onSaveSet(index, reps, weight),
                  )
                : ExerciseSetCard(
                    index: index,
                    reps: entry.reps,
                    weight: entry.weight,
                    width: width,
                    height: height,
                    glass: glass,
                    onDelete: () => onDeleteSet(index),
                  ),
          ),
        );
      },
    );
  }
}
