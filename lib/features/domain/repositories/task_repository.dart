import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks();
  Future<void> addTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(int id);
}
