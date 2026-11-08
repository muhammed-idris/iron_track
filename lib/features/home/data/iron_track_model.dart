class IronTrackModel {
  final int? id;
  final String? workoutTitle;
  final String? weekday;
  final String? date;
  final String? exerciseTitle;
  final int? sets;
  final int? reps;
  final double? weight;
  final List<IronTrackModel>? exercises;

  IronTrackModel({
    this.id,
    this.workoutTitle,
    this.weekday,
    this.date,
    this.exerciseTitle,
    this.sets,
    this.reps,
    this.weight,
    this.exercises,
  });

  static IronTrackModel fromJson(Map<String, dynamic> json) => IronTrackModel(
    id: json['id'] as int?,
    workoutTitle: json['workoutTitle'] as String?,
    weekday: json['day'] as String?,
    date: json['date'] as String?,
    exerciseTitle: json['exerciseTitle'] as String?,
    sets: json['sets'] as int?,
    reps: json['reps'] as int?,
    weight: (json['weight'] as num?)?.toDouble(),
  );

  static Map<String, dynamic> toJson(IronTrackModel item) => {
    if (item.id != null) 'id': item.id,
    'workoutTitle': item.workoutTitle,
    'day': item.weekday,
    'date': item.date,
    'exerciseTitle': item.exerciseTitle,
    'sets': item.sets,
    'reps': item.reps,
    'weight': item.weight,
  };

  IronTrackModel copyWith({
    int? id,
    String? workoutTitle,
    String? weekday,
    String? date,
    String? exerciseTitle,
    int? sets,
    int? reps,
    double? weight,
    List<IronTrackModel>? exercises,
  }) {
    return IronTrackModel(
      id: id ?? this.id,
      workoutTitle: workoutTitle ?? this.workoutTitle,
      weekday: weekday ?? this.weekday,
      date: date ?? this.date,
      exerciseTitle: exerciseTitle ?? this.exerciseTitle,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      exercises: exercises ?? this.exercises,
    );
  }
}