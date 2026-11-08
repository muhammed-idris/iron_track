import '../../edit/data/set_model.dart';

class ExerciseModel {
  final int? id;
  final String? workoutTitle;
  final String? weekday;
  final String? date;
  final String? exerciseTitle;
  final int? setsCount;
  final int? reps;
  final double? weight;
  final List<SetEntry>? setEntries;

  ExerciseModel({
    this.id,
    this.workoutTitle,
    this.weekday,
    this.date,
    this.exerciseTitle,
    this.setsCount,
    this.reps,
    this.weight,
    this.setEntries,
  });

  static ExerciseModel fromJson(Map<String, dynamic> json) => ExerciseModel(
    id: json['id'] as int?,
    workoutTitle: json['workoutTitle'] as String?,
    weekday: json['day'] as String?,
    date: json['date'] as String?,
    exerciseTitle: json['exerciseTitle'] as String?,
    setsCount: json['sets'] as int?,
    reps: json['reps'] as int?,
    weight: (json['weight'] as num?)?.toDouble(),
  );

  static Map<String, dynamic> toJson(ExerciseModel item) => {
    if (item.id != null) 'id': item.id,
    'workoutTitle': item.workoutTitle,
    'day': item.weekday,
    'date': item.date,
    'exerciseTitle': item.exerciseTitle,
    'sets': item.setsCount,
    'reps': item.reps,
    'weight': item.weight,
  };

  ExerciseModel copyWith({
    int? id,
    String? workoutTitle,
    String? weekday,
    String? date,
    String? exerciseTitle,
    int? setsCount,
    int? reps,
    double? weight,
    List<SetEntry>? setEntries,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      workoutTitle: workoutTitle ?? this.workoutTitle,
      weekday: weekday ?? this.weekday,
      date: date ?? this.date,
      exerciseTitle: exerciseTitle ?? this.exerciseTitle,
      setsCount: setsCount ?? this.setsCount,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      setEntries: setEntries ?? this.setEntries,
    );
  }
}
