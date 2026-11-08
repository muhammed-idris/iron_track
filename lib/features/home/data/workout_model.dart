import 'exercise_model.dart';

class WorkoutModel {
  final int? id;
  final String title;
  final String? weekday;
  final String date;
  final List<ExerciseModel> exercises;

  WorkoutModel({
    this.id,
    required this.title,
    this.weekday,
    required this.date,
    required this.exercises,
  });

  int get exerciseCount => exercises.length;

  WorkoutModel copyWith({
    int? id,
    String? title,
    String? weekday,
    String? date,
    List<ExerciseModel>? exercises,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      title: title ?? this.title,
      weekday: weekday ?? this.weekday,
      date: date ?? this.date,
      exercises: exercises ?? this.exercises,
    );
  }
}
