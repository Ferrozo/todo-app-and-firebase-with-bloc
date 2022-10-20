import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/data/models/task.dart';
import 'package:todo_app_with_firebase/src/domain/usecases/id_generator.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks_bloc.dart';

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
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              var task =
                  Task(title: titleController.text, taskId: GUIDGen.generate());
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
