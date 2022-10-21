import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/data/models/task.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/auth/auth_state.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks/tasks_bloc.dart';

import '../../widgets/add_task_input.dart';
import '../../widgets/todo_list.dart';
import '../left_bar/left_bar.dart';
import '../sign_in/sign_in.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const id = 'main_page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const SingleChildScrollView(
        child: AddTaskInput(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showCurrentUser = FirebaseAuth.instance.currentUser!;
    // final List categoryList = ['Studies', 'Work', 'Business'];
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> todosList = state.allTasks;
        return Scaffold(
          backgroundColor: const Color(0xFF1D1D29),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  showCurrentUser.photoURL != null
                      ? Container(
                          height: 45,
                          width: 45,
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
                          width: 30,
                        ),
                ],
              ),
            ),
          ),
          drawer: const LeftBar(),
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
                          'Hi, ${showCurrentUser.displayName}!',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : const Text(
                          'Hi, Dude!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Today\'s Goal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocBuilder<TasksBloc, TasksState>(
                        builder: (context, state) {
                          return Text(
                            '${state.allTasks.length}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
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
