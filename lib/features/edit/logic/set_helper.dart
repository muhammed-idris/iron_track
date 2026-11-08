import 'package:sqflite/sqflite.dart';
import '../../home/logic/iron_track_helper.dart';
import '../data/set_model.dart';

class SetEntryHelper {
  const SetEntryHelper._();

  static const String _tableName = 'set_entries';

  static Future<Database> get _database => IronTrackHelper.database;

  static Future<int> create(SetEntry item) async {
    final db = await _database;
    return db.insert(
      _tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<SetEntry>> readByExercise(int exerciseId) async {
    final db = await _database;
    final maps = await db.query(
      _tableName,
      where: 'exerciseId = ?',
      whereArgs: [exerciseId],
      orderBy: 'setIndex ASC',
    );
    return maps.map(SetEntry.fromJson).toList();
  }

  static Future<int> update(SetEntry item) async {
    final db = await _database;
    return db.update(
      _tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await _database;
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteByExercise(int exerciseId) async {
    final db = await _database;
    return db.delete(
      _tableName,
      where: 'exerciseId = ?',
      whereArgs: [exerciseId],
    );
  }

  static Future<void> replaceForExercise(
    int exerciseId,
    List<SetEntry> entries,
  ) async {
    final db = await _database;
    await db.transaction((txn) async {
      final batch = txn.batch();
      batch.delete(
        _tableName,
        where: 'exerciseId = ?',
        whereArgs: [exerciseId],
      );

      for (var i = 0; i < entries.length; i++) {
        final entry = entries[i].copyWith(
          exerciseId: exerciseId,
          setIndex: i,
        );
        batch.insert(_tableName, entry.toMap());
      }

      await batch.commit(noResult: true);
    });
  }
}
