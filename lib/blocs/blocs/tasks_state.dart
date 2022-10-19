part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({
    this.allTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });

  final List<Task> allTasks;
  final List<Task> removedTasks;

  @override
  List<Object> get props => [allTasks, removedTasks];

  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTasks.map((v) => v.toMap()).toList(),
      'removedTasks': removedTasks.map((v) => v.toMap()).toList()
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        allTasks: List<Task>.from(map['allTasks']?.map((v) => Task.fromMap(v))),
        removedTasks:
            List<Task>.from(map['removedTasks']?.map((v) => Task.fromMap(v))));
  }
}
