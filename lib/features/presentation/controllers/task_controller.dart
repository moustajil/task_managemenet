import 'package:get/get.dart';
import 'package:taskmanagenet/features/domain/usecases/delet_task.dart';
import 'package:taskmanagenet/features/domain/usecases/get_all_task.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/update_task.dart';

class TaskController extends GetxController {
  final GetAllTasks getAllTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;

  TaskController({
    required this.getAllTasks,
    required this.addTask,
    required this.deleteTask,
    required this.updateTask,
  });

  var tasks = <TaskEntity>[].obs;

  @override
  void onInit() {
    loadTasks();
    super.onInit();
  }

  void loadTasks() async {
    tasks.value = await getAllTasks();
  }

  void addNewTask(TaskEntity task) async {
    await addTask(task);
    loadTasks();
  }

  void toggleTask(TaskEntity task) async {
    await updateTask(task.copyWith(isDone: !task.isDone));
    loadTasks();
  }

  void removeTask(int id) async {
    await deleteTask(id);
    loadTasks();
  }
}
