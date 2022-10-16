part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({
    this.allTasks = const <Task>[],
  });

  final List<Task> allTasks;

  @override
  List<Object> get props => [allTasks];
}
