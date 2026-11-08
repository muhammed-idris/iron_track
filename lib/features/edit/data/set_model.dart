class SetEntry {
  final int? id;
  final int exerciseId;
  final int setIndex;
  final int reps;
  final double weight;
  final bool isCompleted;

  const SetEntry({
    this.id,
    required this.exerciseId,
    required this.setIndex,
    required this.reps,
    required this.weight,
    this.isCompleted = false,
  });

  factory SetEntry.fromJson(Map<String, dynamic> json) => SetEntry(
        id: json['id'] as int?,
        exerciseId: json['exerciseId'] as int,
        setIndex: json['setIndex'] as int,
        reps: json['reps'] as int? ?? 0,
        weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
        isCompleted: json['isCompleted'] == 1,
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'exerciseId': exerciseId,
        'setIndex': setIndex,
        'reps': reps,
        'weight': weight,
        'isCompleted': isCompleted ? 1 : 0,
      };

  static Map<String, dynamic> toJson(SetEntry item) => item.toMap();

  SetEntry copyWith({
    int? id,
    int? exerciseId,
    int? setIndex,
    int? reps,
    double? weight,
    bool? isCompleted,
  }) {
    return SetEntry(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      setIndex: setIndex ?? this.setIndex,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetEntry &&
          other.id == id &&
          other.exerciseId == exerciseId &&
          other.setIndex == setIndex &&
          other.reps == reps &&
          other.weight == weight &&
          other.isCompleted == isCompleted);

  @override
  int get hashCode => Object.hash(
        id,
        exerciseId,
        setIndex,
        reps,
        weight,
        isCompleted,
      );
}
