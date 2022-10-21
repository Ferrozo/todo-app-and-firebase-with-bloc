import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/data/models/task.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/widgets/task_tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    Key? key,
    required this.todosList,
  }) : super(key: key);

  final List<Task> todosList;

  void _moveToTrashOrDeleteTask(BuildContext value, Task task) {
    task.isDeleted!
        ? value.read<TasksBloc>().add(DeleteTask(task: task))
        : value.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todosList.length,
        itemBuilder: (context, index) {
          var todo = todosList[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => _moveToTrashOrDeleteTask(context, todo),
            background: Container(
              alignment: Alignment.centerRight,
              height: 60,
              margin: const EdgeInsets.only(
                top: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 60,
              margin: const EdgeInsets.only(
                top: 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF242432),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TaskTile(todo: todo),
            ),
          );
        },
      ),
    );
  }
}
