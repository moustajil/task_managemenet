import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taskmanagenet/core/constants/app_colors.dart';
import 'package:taskmanagenet/features/data/models/task_model.dart';

class TaskGridItem extends StatefulWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPauseToggle;

  const TaskGridItem({
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.onPauseToggle,
    super.key,
  });

  @override
  State<TaskGridItem> createState() => _TaskGridItemState();
}

class _TaskGridItemState extends State<TaskGridItem> {
  late double progress;
  late bool isPaused;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    progress = widget.task.progress;
    isPaused = widget.task.isPaused;

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isPaused) {
        final totalSeconds = getTotalSeconds();
        setState(() {
          progress += 1 / totalSeconds;
          if (progress >= 1.0) {
            progress = 1.0;
            isPaused = true; // auto-pause when complete
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  int getTotalSeconds() {
    final start = widget.task.startTime.hour * 3600 + widget.task.startTime.minute * 60;
    final end = widget.task.endTime.hour * 3600 + widget.task.endTime.minute * 60;
    return end - start;
  }

  int getRemainingSeconds() {
    final total = getTotalSeconds();
    final remaining = (total - (progress * total)).toInt();
    return remaining < 0 ? 0 : remaining;
  }

  String formatSecondsToHMS(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2,'0')}:${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }

  void togglePause() {
    setState(() => isPaused = !isPaused);
    widget.onPauseToggle(); // notify parent
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // Navigate to task detail if needed
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _TaskTitleRow(
                title: widget.task.title,
                onEdit: widget.onEdit,
                onDelete: widget.onDelete,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    widget.task.description,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _TaskProgressBar(
                progress: progress,
                remainingTime: formatSecondsToHMS(getRemainingSeconds()),
              ),
              const SizedBox(height: 12),
              _TaskTimeRow(
                startTime: widget.task.startTime,
                endTime: widget.task.endTime,
                isPaused: isPaused,
                onPauseToggle: togglePause,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskTitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TaskTitleRow({
    required this.title,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 4),
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: IconButton(
            icon: const Icon(Icons.edit, size: 18, color: AppColors.primary),
            onPressed: onEdit,
          ),
        ),
        const SizedBox(width: 4),
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.red.withOpacity(0.1),
          child: IconButton(
            icon: const Icon(Icons.delete, size: 18, color: Colors.red),
            onPressed: onDelete,
          ),
        ),
      ],
    );
  }
}

class _TaskProgressBar extends StatelessWidget {
  final double progress;
  final String remainingTime;

  const _TaskProgressBar({required this.progress, required this.remainingTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: Colors.grey[200],
          color: AppColors.primary,
        ),
        const SizedBox(height: 4),
        Text(
          remainingTime,
          style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
        ),
      ],
    );
  }
}

class _TaskTimeRow extends StatelessWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isPaused;
  final VoidCallback onPauseToggle;

  const _TaskTimeRow({
    required this.startTime,
    required this.endTime,
    required this.isPaused,
    required this.onPauseToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isPaused ? AppColors.primary : Colors.grey[300],
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(8),
            elevation: 0,
          ),
          onPressed: onPauseToggle,
          child: Icon(
            isPaused ? Icons.play_arrow : Icons.pause,
            color: isPaused ? Colors.white : Colors.black54,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "${startTime.format(context)} - ${endTime.format(context)}",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
