import 'package:flutter/material.dart';

class Task {
  final DateTime date;
  final String title;
  final String description;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int durationHours;
  final int durationMinutes;
  double progress;
  bool isPaused;
  int elapsedSeconds;
  late final int totalSeconds;


  Task({
    required this.date,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.durationHours,
    required this.durationMinutes,
    this.progress = 0.0,
    this.isPaused = false,
  })  : elapsedSeconds = 0,
        totalSeconds = durationHours * 3600 + durationMinutes * 60;
}
