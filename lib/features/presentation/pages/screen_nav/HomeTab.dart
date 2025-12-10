import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:taskmanagenet/core/constants/app_colors.dart';
import 'dart:async';

import 'package:taskmanagenet/features/data/models/task_model.dart' show Task;
import 'package:taskmanagenet/features/presentation/widget/dialogs/add_task_dialog.dart';
import 'package:taskmanagenet/features/presentation/widget/task_grid_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DateTime _selectedDate = DateTime.now();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        for (var task in tasks) {
          if (!task.isPaused && task.progress < 1.0) {
            task.elapsedSeconds++;
            task.progress = task.elapsedSeconds / task.totalSeconds;
            if (task.progress > 1.0) task.progress = 1.0;
          }
        }
      });
    });
  }

  void _onDateChange(DateTime date) {
    setState(() => _selectedDate = date);
  }

  void _addTask() async {
    final newTask = await showDialog<Task>(
      context: context,
      builder: (context) => AddTaskDialog(selectedDate: _selectedDate),
    );
    if (newTask != null) setState(() => tasks.add(newTask));
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = tasks
        .where(
          (t) =>
              t.date.year == _selectedDate.year &&
              t.date.month == _selectedDate.month &&
              t.date.day == _selectedDate.day,
        )
        .toList();

    double bottomPadding = MediaQuery.of(context).padding.bottom + 80;

    return Stack(
      children: [
        Column(
          children: [
            EasyDateTimeLine(
              initialDate: _selectedDate,
              onDateChange: _onDateChange,
              dayProps: const EasyDayProps(width: 64, height: 80),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredTasks.isEmpty
                  ? const Center(
                      child: Text(
                        "No tasks for this date.\nClick + to add",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : MasonryGridView.count(
                      padding: const EdgeInsets.all(10),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        return TaskGridItem(
                          task: task,
                          onPauseToggle: () {
                            setState(() => task.isPaused = !task.isPaused);
                          },
                          onDelete: () {
                            setState(() {
                              tasks.remove(task);
                            });
                          },
                          onEdit: () async {
                            final editedTask = await showDialog<Task>(
                              context: context,
                              builder: (context) =>
                                  AddTaskDialog(selectedDate: task.date),
                            );
                            if (editedTask != null) {
                              setState(() {
                                final taskIndex = tasks.indexOf(task);
                                tasks[taskIndex] = editedTask;
                              });
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
        Positioned(
          bottom: bottomPadding,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: AppColors.primary,
            onPressed: _addTask,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
