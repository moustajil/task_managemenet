import 'package:flutter/material.dart';
import 'package:taskmanagenet/core/constants/app_colors.dart';
import 'package:taskmanagenet/features/data/models/task_model.dart' show Task;

class AddTaskDialog extends StatefulWidget {
  final DateTime selectedDate;
  const AddTaskDialog({required this.selectedDate, super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String title = '';
  String description = '';
  TimeOfDay? startTime;
  int durationHours = 0;
  int durationMinutes = 30;

  TimeOfDay? get endTime {
    if (startTime == null) return null;
    final totalMinutes =
        startTime!.hour * 60 +
        startTime!.minute +
        durationHours * 60 +
        durationMinutes;
    final h = (totalMinutes ~/ 60) % 24;
    final m = totalMinutes % 60;
    return TimeOfDay(hour: h, minute: m);
  }

  Widget _buildDropdown({
    required int value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    double? width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<int>(
        isExpanded: true,
        underline: const SizedBox(),
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Add New Task",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Title
              TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.title, color: AppColors.primary),
                ),
                onChanged: (v) => title = v,
              ),
              const SizedBox(height: 15),

              // Description
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Description",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.description, color: AppColors.primary),
                ),
                onChanged: (v) => description = v,
              ),
              const SizedBox(height: 20),

              // --- First line: Hours & Minutes ---
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      value: durationHours,
                      items: List.generate(
                        24,
                        (index) => DropdownMenuItem(
                          value: index,
                          child: Text("${index}h"),
                        ),
                      ),
                      onChanged: (val) => setState(() => durationHours = val!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdown(
                      value: durationMinutes,
                      items: List.generate(
                        12,
                        (index) => DropdownMenuItem(
                          value: index * 5,
                          child: Text("${index * 5}m"),
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => durationMinutes = val!),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // --- Second line: Start Time ---
              GestureDetector(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) setState(() => startTime = picked);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      startTime != null
                          ? "Start: ${startTime!.format(context)}"
                          : "Pick Start Time",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // End Time Preview
              if (endTime != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Ends at: ${endTime!.format(context)}",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 25),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      if (title.isNotEmpty &&
                          description.isNotEmpty &&
                          startTime != null) {
                        final task = Task(
                          date: widget.selectedDate,
                          title: title,
                          description: description,
                          startTime: startTime!,
                          endTime: endTime!,
                          durationHours: durationHours,
                          durationMinutes: durationMinutes,
                          progress: 0.0,
                          isPaused: true, // <-- start paused
                        );
                        Navigator.pop(context, task);
                      }
                    },
                    child: const Text(
                      "Add Task",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
