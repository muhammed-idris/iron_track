import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/features/home/data/exercise_model.dart';
import 'package:iron_track/features/home/logic/iron_track_helper.dart';
import 'package:iron_track/features/log/widgets/section_widgets/week_selector_widget.dart';
import '../../../core/constants/colors_manager.dart';
import '../../../shared/customs/custom_animate.dart';
import '../../../shared/customs/custom_snack_bar.dart';
import '../../home/data/workout_model.dart';
import '../widgets/section_widgets/exercises_list_card.dart';
import '../widgets/section_widgets/log_app_bar.dart';
import '../widgets/workout_refresh_notifier.dart';

class LogView extends StatefulWidget {
  const LogView({super.key, this.onWorkoutCreated, this.workout});

  final VoidCallback? onWorkoutCreated;
  final WorkoutModel? workout;

  @override
  State<LogView> createState() => LogViewState();
}

class LogViewState extends State<LogView> {
  List<ExerciseModel> exercises = [];
  bool isLoading = false;
  int selectedDayIndex = 0;
  final TextEditingController workoutTitleController = TextEditingController();

  static const List<String> dayNames = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  String get selectedDayName => dayNames[selectedDayIndex];

  @override
  void initState() {
    super.initState();

    if (widget.workout != null) {
      final workoutDayIndex = widget.workout!.weekday != null
          ? dayNames.indexOf(widget.workout!.weekday!)
          : -1;
      selectedDayIndex = workoutDayIndex != -1
          ? workoutDayIndex
          : DateTime.now().weekday % 7;
      workoutTitleController.text = widget.workout!.title;
      exercises = List<ExerciseModel>.from(widget.workout!.exercises);
    } else {
      selectedDayIndex = DateTime.now().weekday % 7;
    }
    loadExercises();
  }

  @override
  void dispose() {
    workoutTitleController.dispose();
    super.dispose();
  }

  Future<void> loadExercises() async {
    setState(() => isLoading = true);
    final result =
        await IronTrackHelper.readDraftExercisesByDay(selectedDayName);
    if (!mounted) return;
    setState(() {
      exercises = result;
      isLoading = false;
    });
  }

  Future<void> clearDraftList() async {
    await loadExercises();
  }

  Future<void> updateExercise(ExerciseModel exercise) async {
    if (exercise.id == null || !mounted) return;
    setState(() {
      final index = exercises.indexWhere((item) => item.id == exercise.id);
      if (index != -1) exercises[index] = exercise;
    });
    workoutRefreshNotifier.bump();
  }

  void deleteExercise(ExerciseModel exercise) {
    if (!mounted) return;
    setState(() {
      exercises.removeWhere((item) => item.id == exercise.id);
    });
    workoutRefreshNotifier.bump();
    AppSnackBar.success(
      context: context,
      message: 'Exercise deleted',
      duration: const Duration(seconds: 2),
    );
  }

  void addExercise(ExerciseModel exercise) {
    if (!mounted) return;
    setState(() => exercises = [...exercises, exercise]);
    workoutRefreshNotifier.bump();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const LogAppBar(title: 'Workout'),
        body: CustomScrollView(
          scrollCacheExtent: const ScrollCacheExtent.pixels(600),
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                left: width * 0.04,
                right: width * 0.04,
                top: height * 0.01,
              ),
              sliver: SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: WeekSelectorWidget(
                    titleController: workoutTitleController,
                    initialSelectedDay: selectedDayIndex,
                    onDaySelected: (index) {
                      setState(() => selectedDayIndex = index);
                      loadExercises();
                    },
                  ).slideUp(
                    delay: 10.ms,
                    duration: 700.ms,
                    curve: Curves.easeInOut,
                    begin: 0.1,
                    end: 0.0,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 25, width * 0.04, 0),
              sliver: SliverToBoxAdapter(
                child: ExerciseListHeader(
                  count: exercises.length,
                  selectedDayName: selectedDayName,
                  onExerciseCreated: () {
                    loadExercises();
                    workoutRefreshNotifier.bump();
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: Gap(15)),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              sliver: _buildExercisesSliver(),
            ),
            SliverToBoxAdapter(child: Gap(height * 0.05)),
          ],
        ),
      ),
    );
  }

  Widget _buildExercisesSliver() {
    final height = MediaQuery.sizeOf(context).height;

    if (isLoading) {
      return const SliverToBoxAdapter(child: ExerciseListLoading());
    }
    if (exercises.isEmpty) {
      return const SliverToBoxAdapter(child: ExerciseListEmpty());
    }
    return SliverList.separated(
      itemCount: exercises.length,
      separatorBuilder: (_, _) => Gap(height * 0.012),
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return ExerciseListItem(
          key: ValueKey(exercise.id ?? index),
          exercise: exercise,
          index: index,
          onDelete: deleteExercise,
          onUpdate: updateExercise,
        );
      },
    );
  }
}
