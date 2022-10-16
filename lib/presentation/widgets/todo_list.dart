import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs/tasks_bloc.dart';
import '../../models/task.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    Key? key,
    required this.todosList,
  }) : super(key: key);

  final List<Task> todosList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todosList.length,
        itemBuilder: (context, index) {
          var todo = todosList[index];
          return Container(
            alignment: Alignment.center,
            height: 60,
            margin: const EdgeInsets.only(
              top: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.indigo[800],
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
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
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              onLongPress: () =>
                  context.read<TasksBloc>().add(DeleteTask(task: todo)),
            ),
          );
        },
      ),
    );
  }
}
