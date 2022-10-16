part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({
    this.allTasks = const <Task>[],
  });

  final List<Task> allTasks;

  @override
  List<Object> get props => [allTasks];

  Map<String, dynamic> toMap() {
    return {'allTasks': allTasks.map((v) => v.toMap()).toList()};
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        allTasks:
            List<Task>.from(map['allTasks']?.map((v) => Task.fromMap(v))));
  }
}
