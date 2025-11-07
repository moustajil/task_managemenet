import 'package:get/get.dart';
import 'package:taskmanagenet/features/data/data_sources/local_data_source.dart';
import 'package:taskmanagenet/features/data/repositories_impl/task_repositoy_impl.dart';
import 'package:taskmanagenet/features/domain/usecases/add_task.dart';
import 'package:taskmanagenet/features/domain/usecases/delet_task.dart';
import 'package:taskmanagenet/features/domain/usecases/get_all_task.dart';
import 'package:taskmanagenet/features/domain/usecases/update_task.dart';
import 'package:taskmanagenet/features/presentation/controllers/task_controller.dart';
import 'package:taskmanagenet/features/presentation/pages/task_list_page.dart';


class AppPages {
  static final routes = [
    GetPage(
      name: '/tasks',
      page: () => TaskListPage(),
      binding: BindingsBuilder(() {
        final localDataSource = LocalDataSourceImpl();
        final repo = TaskRepositoryImpl(localDataSource);
        Get.put(TaskController(
          getAllTasks: GetAllTasks(repo),
          addTask: AddTask(repo),
          deleteTask: DeleteTask(repo),
          updateTask: UpdateTask(repo),
        ));
      }),
    ),
  ];
}
