// ignore_for_file: unnecessary_this

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  Task(
      {required this.title,
      required this.taskId,
      this.isDone,
      this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }
  final String taskId;
  final String title;
  bool? isDone;
  bool? isDeleted;

  Task copyWith({
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
        title: title ?? this.title,
        taskId: this.taskId,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'taskId': taskId,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      taskId: map['taskId'],
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  @override
  List<Object?> get props => [title, taskId, isDone, isDeleted];
}
