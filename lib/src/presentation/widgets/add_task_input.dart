import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/data/models/task.dart';
import 'package:todo_app_with_firebase/src/domain/usecases/id_generator.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks/tasks_bloc.dart';

class AddTaskInput extends StatelessWidget {
  const AddTaskInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    return Container(
      color: const Color(0xFF1D1D29),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              height: 65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 49, 49, 67),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                autofocus: true,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                controller: titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Task',
                  suffixIcon: IconButton(
                      onPressed: () {
                        var task = Task(
                            title: titleController.text,
                            taskId: GUIDGen.generate());
                        context.read<TasksBloc>().add(AddTask(task: task));
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.add)),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                  ),
                ),
              ),
            ),
            // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //   TextButton(
            //     onPressed: () => Navigator.pop(context),
            //     child: const Text('Cancel'),
            //   ),
            //   ElevatedButton(
            //     onPressed: () {
            //       var task = Task(
            //           title: titleController.text, taskId: GUIDGen.generate());
            //       context.read<TasksBloc>().add(AddTask(task: task));
            //       Navigator.pop(context);
            //     },
            //     child: const Text('Add'),
            //   )
            // ]),
          ],
        ),
      ),
    );
  }
}
