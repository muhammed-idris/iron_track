import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../log/widgets/workout_refresh_notifier.dart';
import '../data/workout_model.dart';
import '../logic/iron_track_helper.dart';
import 'workout_card.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class NextWorkoutWidget extends StatefulWidget {
  const NextWorkoutWidget({super.key});

  @override
  State<NextWorkoutWidget> createState() => _NextWorkoutWidgetState();
}

class _NextWorkoutWidgetState extends State<NextWorkoutWidget> with RouteAware {
  List<WorkoutModel> workouts = [];
  bool isLoading = true;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadUpcomingWorkouts();
    workoutRefreshNotifier.addListener(_onWorkoutDataChanged);
  }

  void _onWorkoutDataChanged() {
    _loadUpcomingWorkouts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void didPopNext() {
    _loadUpcomingWorkouts();
  }

  @override
  void dispose() {
    workoutRefreshNotifier.removeListener(_onWorkoutDataChanged);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Future<void> _loadUpcomingWorkouts() async {
    final data = await IronTrackHelper.readUpcomingWorkouts();
    if (!mounted) return;

    setState(() {
      workouts = data;
      if (currentPage >= workouts.length && workouts.isNotEmpty) {
        currentPage = 0;
      }
      isLoading = false;
    });
  }

  String _formatDayLabel(String day) {
    const days = {
      'Sun': DateTime.sunday,
      'Mon': DateTime.monday,
      'Tue': DateTime.tuesday,
      'Wed': DateTime.wednesday,
      'Thu': DateTime.thursday,
      'Fri': DateTime.friday,
      'Sat': DateTime.saturday,
    };

    final target = days[day];
    if (target == null) return '';

    final today = DateTime.now();
    final diff = (target - today.weekday) % 7;
    final date = today.add(Duration(days: diff));
    return DateFormat('dd/MM').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    if (isLoading || workouts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index, realIndex) {
            return WorkoutCard(
              workout: workouts[index],
              dateLabel: _formatDayLabel(workouts[index].weekday ?? ''),
            );
          },
          options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            enableInfiniteScroll: false,
            padEnds: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            workouts.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: currentPage == index ? 20 : 7,
              height: height * 0.007,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? context.glass.textMuted
                    : Colors.grey.withValues(alpha: .35),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ).animate().fadeIn(),
      ],
    );
  }
}
