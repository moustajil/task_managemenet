import 'package:taskmanagenet/features/data/data_sources/local_data_source.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTask(TaskEntity task) =>
      localDataSource.addTask(TaskModel.fromEntity(task));

  @override
  Future<void> deleteTask(int id) => localDataSource.deleteTask(id);

  @override
  Future<List<TaskEntity>> getAllTasks() => localDataSource.getAllTasks();

  @override
  Future<void> updateTask(TaskEntity task) =>
      localDataSource.updateTask(TaskModel.fromEntity(task));
}
