import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs/tasks_bloc.dart';
import '../../models/task.dart';

class AddTaskInput extends StatelessWidget {
  const AddTaskInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          const Text(
            'Add your Task',
          ),
          TextField(
            autofocus: true,
            controller: titleController,
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              var task = Task(title: titleController.text);
              context.read<TasksBloc>().add(AddTask(task: task));
              Navigator.pop(context);
            },
            child: const Text(''),
          )
        ],
      ),
    );
  }
}
