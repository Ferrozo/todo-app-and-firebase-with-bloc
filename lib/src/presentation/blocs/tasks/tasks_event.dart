part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  const AddTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TasksEvent {
  const UpdateTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class RemoveTask extends TasksEvent {
  const RemoveTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  const DeleteTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}
