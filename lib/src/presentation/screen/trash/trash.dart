import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/widgets/todo_list.dart';
import '../left_bar/left_bar.dart';

class Trash extends StatelessWidget {
  const Trash({Key? key}) : super(key: key);

  static const id = 'trash_id_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF181920),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Trash'),
          ),
          drawer: const LeftBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(label: Text('${state.removedTasks.length}')),
              ),
              TodoList(todosList: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
