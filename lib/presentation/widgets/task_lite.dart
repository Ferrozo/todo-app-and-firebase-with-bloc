import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs/tasks_bloc.dart';
import '../../models/task.dart';

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
            borderRadius: BorderRadius.all(Radius.circular(50))),
        value: todo.isDone,
        onChanged: (v) {
          context.read<TasksBloc>().add(UpdateTask(task: todo));
        },
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
      onLongPress: () => context.read<TasksBloc>().add(DeleteTask(task: todo)),
    );
  }
}
