import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/data/models/task.dart';
import 'package:todo_app_with_firebase/src/presentation/widgets/task_tile.dart';

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
            child: TaskTile(todo: todo),
          );
        },
      ),
    );
  }
}
