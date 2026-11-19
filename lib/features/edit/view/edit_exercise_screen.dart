import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/home/data/exercise_model.dart';
import 'package:iron_track/shared/customs/custom_btn.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../../home/widgets/delete_widget.dart';
import '../../log/widgets/workout_refresh_notifier.dart';
import '../data/set_model.dart';
import '../logic/set_helper.dart';
import '../widget/add_set_dialog.dart';
import '../widget/edit_list_widget.dart';
import '../widget/edit_screen_header.dart';
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

    final header = ExerciseTitleHeader(
      title: _exerciseNameController.text.trim(),
      glass: glass,
      setsCount: _setEntries.length,
      totalVolume: _setEntries.fold<double>(
        0,
            (sum, e) => sum + e.reps * e.weight,
      ),
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          _persistChanges();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            header,
            Expanded(
              child: _loadingSetEntries
                  ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColor.primary,
                  radius: 15,
                ),
              )
                  : ExerciseSetList(
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
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.01, bottom: 8),
                child: CustomBtn(
                  borderRadius: 25,
                  height: height * 0.06,
                  width: width * 0.85,
                  text: 'Add Set',
                  icon: Icons.add_circle,
                  btnColors: [
                    AppColor.primary,
                    AppColor.primary.withValues(alpha: 0.8),
                  ],
                  animateIn: true,
                  onTap: _addSet,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}