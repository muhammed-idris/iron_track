import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../edit/data/set_model.dart';
import '../data/exercise_model.dart';
import '../data/workout_model.dart';

class IronTrackHelper {
  static Database? _database;

  static const List<String> weekDays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  static Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'iron_track.db');
    return openDatabase(
      path,
      version: 6,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE iron_track(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            workoutTitle TEXT,
            day TEXT,
            date TEXT,
            exerciseTitle TEXT,
            sets INTEGER,
            reps INTEGER,
            weight REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE workout_titles(
            day TEXT PRIMARY KEY,
            title TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE set_entries(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            exerciseId INTEGER NOT NULL,
            setIndex INTEGER NOT NULL,
            reps INTEGER,
            weight REAL,
            isCompleted INTEGER NOT NULL DEFAULT 0,
            FOREIGN KEY (exerciseId) REFERENCES iron_track (id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE INDEX idx_set_entries_exerciseId ON set_entries(exerciseId)
        ''');

        await db.execute('''
          CREATE INDEX idx_iron_track_workout_date ON iron_track(workoutTitle, date)
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE iron_track_new(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              workoutTitle TEXT,
              day TEXT,
              date TEXT,
              exerciseTitle TEXT,
              sets INTEGER,
              reps INTEGER,
              weight REAL
            )
          ''');
          await db.execute('''
            INSERT INTO iron_track_new
            (id, workoutTitle, day, date, exerciseTitle, sets, reps, weight)
            SELECT id, workoutTitle, day, date, exerciseTitle, sets, reps, weight
            FROM iron_track
          ''');
          await db.execute('DROP TABLE iron_track');
          await db.execute('ALTER TABLE iron_track_new RENAME TO iron_track');
        }
        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS workout_titles(day TEXT PRIMARY KEY, title TEXT)
          ''');
        }
        if (oldVersion < 4) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS set_entries(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              exerciseId INTEGER NOT NULL,
              setIndex INTEGER NOT NULL,
              reps INTEGER,
              weight REAL,
              isCompleted INTEGER NOT NULL DEFAULT 0,
              FOREIGN KEY (exerciseId) REFERENCES iron_track (id) ON DELETE CASCADE
            )
          ''');
          await db.execute('''
            CREATE INDEX IF NOT EXISTS idx_set_entries_exerciseId
            ON set_entries(exerciseId)
          ''');
        }
        if (oldVersion < 6) {
          final columns = await db.rawQuery('PRAGMA table_info(set_entries)');
          final hasIsCompleted = columns.any((c) => c['name'] == 'isCompleted');
          if (!hasIsCompleted) {
            await db.execute('''
              ALTER TABLE set_entries ADD COLUMN isCompleted INTEGER NOT NULL DEFAULT 0
            ''');
          }

          await db.execute('''
            CREATE INDEX IF NOT EXISTS idx_iron_track_workout_date 
            ON iron_track(workoutTitle, date)
          ''');
        }
      },
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  static Future<int> create(ExerciseModel item) async {
    final db = await database;
    return db.transaction((txn) async {
      final exerciseId = await txn.insert(
        'iron_track',
        ExerciseModel.toJson(item),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      final count = item.setsCount ?? 0;
      if (count > 0) {
        final batch = txn.batch();
        for (var i = 0; i < count; i++) {
          final entry = SetEntry(
            exerciseId: exerciseId,
            setIndex: i,
            reps: item.reps ?? 0,
            weight: item.weight ?? 0.0,
          );
          batch.insert('set_entries', SetEntry.toJson(entry));
        }
        await batch.commit(noResult: true);
      }

      return exerciseId;
    });
  }

  static Future<List<ExerciseModel>> readDraftExercisesByDay(String day) async {
    final db = await database;
    final maps = await db.query(
      'iron_track',
      where: '(workoutTitle IS NULL OR workoutTitle = ?) AND day = ?',
      whereArgs: ['', day],
      orderBy: 'id ASC',
    );
    return maps.map(ExerciseModel.fromJson).toList();
  }

  static Future<WorkoutModel?> readTodayWorkout() async {
    final now = DateTime.now();
    final dayName = weekDays[now.weekday % 7];

    final title = await getWorkoutTitle(dayName);
    final exercises = await readDraftExercisesByDay(dayName);

    final hasTitle = title != null && title.trim().isNotEmpty;
    if (!hasTitle && exercises.isEmpty) return null;

    final formattedDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    return WorkoutModel(
      title: hasTitle ? title.trim() : '$dayName Workout',
      weekday: dayName,
      date: formattedDate,
      exercises: exercises,
    );
  }

  static Future<WorkoutModel?> readWorkoutByDay(String day) async {
    final title = await getWorkoutTitle(day);
    final exercises = await readDraftExercisesByDay(day);

    final hasTitle = title != null && title.trim().isNotEmpty;
    if (!hasTitle && exercises.isEmpty) return null;

    return WorkoutModel(
      title: hasTitle ? title.trim() : '$day Workout',
      weekday: day,
      date: '',
      exercises: exercises,
    );
  }

  static Future<List<WorkoutModel>> readWeeklyWorkouts() async {
    final List<WorkoutModel> workouts = [];

    for (final day in weekDays) {
      final workout = await readWorkoutByDay(day);
      if (workout != null) {
        workouts.add(workout);
      }
    }

    return workouts;
  }

  static Future<List<WorkoutModel>> readUpcomingWorkouts() async {
    final workouts = await readWeeklyWorkouts();
    if (workouts.isEmpty) return workouts;

    final today = weekDays[DateTime.now().weekday % 7];
    final startIndex =
        workouts.indexWhere((workout) => workout.weekday == today);

    if (startIndex == -1) {
      return workouts;
    }

    return [
      ...workouts.sublist(startIndex),
      ...workouts.sublist(0, startIndex),
    ];
  }

  static Future<int> update(ExerciseModel item) async {
    final db = await database;
    return db.update(
      'iron_track',
      ExerciseModel.toJson(item),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await database;
    return db.transaction((txn) async {
      await txn.delete(
        'set_entries',
        where: 'exerciseId = ?',
        whereArgs: [id],
      );
      return txn.delete(
        'iron_track',
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  static Future<void> saveWorkoutTitle(String day, String title) async {
    final db = await database;
    await db.insert(
      'workout_titles',
      {'day': day, 'title': title.trim()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getWorkoutTitle(String day) async {
    final db = await database;
    final result = await db.query(
      'workout_titles',
      where: 'day = ?',
      whereArgs: [day],
    );
    if (result.isEmpty) return null;
    return result.first['title'] as String?;
  }

  static Future<void> deleteWorkoutTitle(String day) async {
    final db = await database;
    await db.delete('workout_titles', where: 'day = ?', whereArgs: [day]);
  }

  static Future<List<WorkoutModel>> readGroupedWorkouts() async {
    final db = await database;
    final allExercises = await db.query(
      'iron_track',
      where: 'workoutTitle IS NOT NULL AND workoutTitle != ?',
      whereArgs: [''],
      orderBy: 'date DESC, id ASC',
    );

    if (allExercises.isEmpty) return [];

    final Map<String, List<ExerciseModel>> grouped = {};
    final List<Map<String, dynamic>> metadata = [];
    final Set<String> seen = {};

    for (final json in allExercises) {
      final title = (json['workoutTitle'] as String?) ?? '';
      final date = (json['date'] as String?) ?? '';
      final key = '$title|$date';

      if (seen.add(key)) {
        metadata.add(json);
        grouped[key] = [];
      }
      grouped[key]!.add(ExerciseModel.fromJson(json));
    }

    return metadata.map((m) {
      final title = (m['workoutTitle'] as String?) ?? '';
      final date = (m['date'] as String?) ?? '';
      final key = '$title|$date';
      return WorkoutModel(
        title: title,
        weekday: m['day'] as String?,
        date: date,
        exercises: grouped[key]!,
      );
    }).toList();
  }

  static Future<List<ExerciseModel>> readByWorkout(
    String workoutTitle,
    String date,
  ) async {
    final db = await database;
    final maps = await db.query(
      'iron_track',
      where: 'workoutTitle = ? AND date = ?',
      whereArgs: [workoutTitle, date],
    );
    return maps.map(ExerciseModel.fromJson).toList();
  }

  static Future<int> clearAll() async {
    final db = await database;
    return db.transaction((txn) async {
      await txn.delete('set_entries');
      await txn.delete('workout_titles');
      return txn.delete('iron_track');
    });
  }
}
