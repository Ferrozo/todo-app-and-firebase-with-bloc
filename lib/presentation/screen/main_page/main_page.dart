import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs/auth_bloc.dart';
import '../../../blocs/blocs/auth_event.dart';
import '../../../blocs/blocs/auth_state.dart';
import '../../../blocs/blocs/tasks_bloc.dart';
import '../../../models/task.dart';
import '../../widgets/todo_list.dart';
import '../sign_in/sign_in.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  TextEditingController titleControll = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AddTaskInput(titleController: titleControll),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showCurrentUser = FirebaseAuth.instance.currentUser!;
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> todosList = state.allTasks;
        return Scaffold(
          backgroundColor: const Color(0xFF181920),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is UnAuthenticated) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                    (route) => false,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showCurrentUser.photoURL != null
                      ? Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0,
                                color: const Color.fromARGB(255, 14, 72, 234)),
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage('${showCurrentUser.photoURL}'),
                            ),
                          ),
                        )
                      : Image.asset(
                          'src/assets/userAvatar.png',
                          width: 40,
                        ),
                  IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutRequested());
                      },
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        size: 20,
                      ))

                  // Text('User: ${showCurrentUser.displayName}'),
                ],
              ),
            ),
          ),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  showCurrentUser.displayName != null
                      ? Text(
                          'What\'s up, ${showCurrentUser.displayName}!',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )
                      : const Text(
                          'What\'s up, Dude!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                  const SizedBox(height: 30),
                  Text(
                    'CATEGORIES',
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 115,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.indigo[800],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0 tasks',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Studies',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          padding: const EdgeInsets.all(20),
                          height: 115,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.indigo[800],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0 tasks',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Business',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          padding: const EdgeInsets.all(20),
                          height: 115,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.indigo[800],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0 tasks',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Work',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'TODAY\'S TASKS',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  TodoList(todosList: todosList),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo[800],
            onPressed: () => _addTask(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class AddTaskInput extends StatelessWidget {
  const AddTaskInput({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
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
            child: Text(''),
          )
        ],
      ),
    );
  }
}
