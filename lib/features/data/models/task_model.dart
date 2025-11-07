import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    int? id,
    required String title,
    required String description,
    bool isDone = false,
    required DateTime createdAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          isDone: isDone,
          createdAt: createdAt,
        );

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['is_done'] == 1,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_done': isDone ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromEntity(TaskEntity entity) => TaskModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        isDone: entity.isDone,
        createdAt: entity.createdAt,
      );
}
