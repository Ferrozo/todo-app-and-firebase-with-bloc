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
          backgroundColor: const Color(0xFF1D1D29),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Trash (${state.removedTasks.length})',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          drawer: const LeftBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TodoList(todosList: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
