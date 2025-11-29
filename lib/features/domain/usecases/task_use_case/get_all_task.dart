import '../../entities/task_entity.dart';
import '../../repositories/task_repository.dart';

class GetAllTasks {
  final TaskRepository repository;

  GetAllTasks(this.repository);

  Future<List<TaskEntity>> call() async {
    return await repository.getAllTasks();
  }
}
