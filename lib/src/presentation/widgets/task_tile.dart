import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/data/models/task.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks/tasks_bloc.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Task todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Checkbox(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        value: todo.isDone,
        onChanged: todo.isDeleted == false
            ? (v) {
                context.read<TasksBloc>().add(UpdateTask(task: todo));
              }
            : null,
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white70,
          decoration: todo.isDone! ? TextDecoration.lineThrough : null,
          // fontWeight: FontWeight.bold,
        ),
      ),
      // onLongPress: () => _moveToTrashOrDeleteTask(context, todo),
    );
  }
}
