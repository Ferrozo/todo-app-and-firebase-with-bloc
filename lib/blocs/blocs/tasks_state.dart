part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({
    this.allTasks = const <Task>[],
    this.removeTasks = const <Task>[],
  });

  final List<Task> allTasks;
  final List<Task> removeTasks;

  @override
  List<Object> get props => [allTasks, removeTasks];

  Map<String, dynamic> toMap() {
    return {'allTasks': allTasks.map((v) => v.toMap()).toList()};
    return {'removeTasks': removeTasks.map((v) => v.toMap()).toList()};
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        allTasks:
            List<Task>.from(map['allTasks']?.map((v) => Task.fromMap(v))));
    removeTasks:
    List<Task>.from(map['removeTasks']?.map((v) => Task.fromMap(v)));
  }
}
