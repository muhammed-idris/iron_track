import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/home/widgets/calendar_track_widget.dart';
import 'package:iron_track/features/home/widgets/info_card.dart';
import 'package:iron_track/features/home/widgets/levels_widget.dart';
import 'package:iron_track/shared/customs/custom_animate.dart';
import '../../log/widgets/workout_refresh_notifier.dart';
import '../data/workout_model.dart';
import '../logic/iron_track_helper.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/next_workout_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  List<WorkoutModel> weekWorkouts = [];
  bool isLoading = true;
  double _cachedVolume = 0;
  int _cachedSets = 0;
  Set<DateTime> _trainedDates = const {};
  int _refreshCount = 0;

  @override
  void initState() {
    super.initState();
    workoutRefreshNotifier.addListener(_onWorkoutDataChanged);
    _loadDashboardData();
  }

  @override
  void dispose() {
    workoutRefreshNotifier.removeListener(_onWorkoutDataChanged);
    super.dispose();
  }

  void _onWorkoutDataChanged() {
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    final workouts = await IronTrackHelper.readWeeklyWorkouts();
    if (!mounted) return;

    int totalWeekSets = 0;
    double totalVolume = 0;
    final now = DateTime.now();
    final activeDates = <DateTime>{
      DateTime(now.year, now.month, 3),
      DateTime(now.year, now.month, 5),
      DateTime(now.year, now.month, 12),
    };

    const dayToWeekday = {
      'Sun': DateTime.sunday,
      'Mon': DateTime.monday,
      'Tue': DateTime.tuesday,
      'Wed': DateTime.wednesday,
      'Thu': DateTime.thursday,
      'Fri': DateTime.friday,
      'Sat': DateTime.saturday,
    };

    for (final workout in workouts) {
      if (workout.exercises.isNotEmpty && workout.weekday != null) {
        final targetWeekday = dayToWeekday[workout.weekday!];
        if (targetWeekday != null) {
          final diff = targetWeekday - now.weekday;
          final d = now.add(Duration(days: diff));
          activeDates.add(DateTime(d.year, d.month, d.day));
        }
      }

      for (final exercise in workout.exercises) {
        final exerciseSets = exercise.setsCount ?? 0;
        final exerciseReps = exercise.reps ?? 0;
        final exerciseWeight = exercise.weight ?? 0.0;

        totalWeekSets += exerciseSets;
        totalVolume += (exerciseSets * exerciseReps) * exerciseWeight;
      }
    }

    setState(() {
      weekWorkouts = workouts;
      _cachedVolume = totalVolume / 10;
      _cachedSets = totalWeekSets;
      _trainedDates = activeDates;
      isLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    await _loadDashboardData();
    if (!mounted) return;
    setState(() => _refreshCount++);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final glass = context.glass;

    return Scaffold(
      appBar: const HomeAppBar(title: 'Muhammed'),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColor.primary,
        backgroundColor: glass.dialogBackground,
        displacement: 40,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                left: width * 0.04,
                right: width * 0.04,
                top: height * 0.005,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  CalendarTrackWidget(
                    trainedDates: _trainedDates,
                  ).slideUp(
                    delay: 10.ms,
                    duration: 700.ms,
                    curve: Curves.easeInOut,
                    begin: 0.1,
                    end: 0.0,
                  ),
                  Gap(height * 0.015),
                  LevelsWidget(volumeXp: _cachedVolume).slideUp(
                    delay: 10.ms,
                    duration: 700.ms,
                    curve: Curves.easeInOut,
                    begin: 0.1,
                    end: 0.0,
                  ),
                  Gap(height * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          icon: Icons.fitness_center_outlined,
                          value: _cachedVolume.toStringAsFixed(1),
                          label: 'Week Volume',
                        ).slideLeft(delay: 100.ms),
                      ),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.format_list_bulleted_outlined,
                          value: _cachedSets.toString(),
                          label: 'Week Sets',
                        ).slideLeft(delay: 200.ms),
                      ),
                      Expanded(
                        child: const InfoCard(
                          icon: Icons.local_fire_department_outlined,
                          value: '12 k',
                          label: 'Calories',
                        ).slideLeft(delay: 300.ms),
                      ),
                    ],
                  ),
                  Gap(height * 0.01),
                  NextWorkoutWidget(key: ValueKey(_refreshCount)).slideUp(
                    delay: 10.ms,
                    duration: 700.ms,
                    curve: Curves.easeInOut,
                    begin: 0.1,
                    end: 0.0,
                  ),
                  Gap(height * 0.01),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
