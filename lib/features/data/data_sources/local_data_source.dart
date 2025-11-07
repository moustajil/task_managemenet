import 'package:sqflite/sqflite.dart';
import 'package:taskmanagenet/core/database/hive_initialiawer.dart';
import '../models/task_model.dart';

abstract class LocalDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
}

class LocalDataSourceImpl implements LocalDataSource {
  Future<Database> get _db async => await AppDatabase.instance.database;

  @override
  Future<void> addTask(TaskModel task) async {
    final db = await _db;
    await db.insert('tasks', task.toMap());
  }

  @override
  Future<void> deleteTask(int id) async {
    final db = await _db;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.map((e) => TaskModel.fromMap(e)).toList();
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final db = await _db;
    await db.update('tasks', task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }
}
