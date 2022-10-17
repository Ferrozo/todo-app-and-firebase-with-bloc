import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs/auth_bloc.dart';
import '../../../blocs/blocs/auth_event.dart';
import '../../../blocs/blocs/auth_state.dart';
import '../../../blocs/blocs/tasks_bloc.dart';
import '../../../models/task.dart';
import '../../widgets/add_task_input.dart';
import '../../widgets/todo_category.dart';
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
    final List categoryList = ['Studies', 'Work', 'Business'];
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
                      Icons.menu,
                      size: 25,
                    ),
                  )
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
                        for (int i = 0; i < 3; i++)
                          TodoCategory(
                            categoryTitle: categoryList[i],
                            numberOfTasks: 0,
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
                  const SizedBox(height: 10),
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
