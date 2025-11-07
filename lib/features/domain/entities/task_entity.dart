class TaskEntity {
  final int? id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;

  TaskEntity({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.createdAt,
  });

  TaskEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
