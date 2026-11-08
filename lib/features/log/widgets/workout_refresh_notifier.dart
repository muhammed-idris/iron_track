import 'package:flutter/foundation.dart';

class WorkoutRefreshNotifier extends ValueNotifier<int> {
  WorkoutRefreshNotifier() : super(0);

  void bump() => value++;
}

final WorkoutRefreshNotifier workoutRefreshNotifier = WorkoutRefreshNotifier();
