import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/auth/auth_state.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/screen/trash/trash.dart';

import '../../blocs/auth/auth_event.dart';
import '../main_page/main_page.dart';
import '../sign_in/sign_in.dart';

class LeftBar extends StatelessWidget {
  const LeftBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showCurrentUser = FirebaseAuth.instance.currentUser!;
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return SafeArea(
          child: BlocListener<TasksBloc, TasksState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              }
            },
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(MainPage.id),
              child: Drawer(
                width: 240,
                // backgroundColor: Colors.indigo[800],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 50),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: showCurrentUser.photoURL != null
                          ? Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '${showCurrentUser.photoURL}'),
                                ),
                              ),
                            )
                          : Image.asset(
                              'src/assets/userAvatar.png',
                              width: 60,
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        showCurrentUser.displayName ?? 'Dude',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(MainPage.id),
                          child: ListTile(
                            leading: const Icon(Icons.list_alt),
                            title: const Text('All tasks'),
                            trailing: Text('${state.allTasks.length}'),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(Trash.id),
                          child: ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Trash'),
                            trailing: Text('${state.removedTasks.length}'),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(SignOutRequested());
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.output,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text('Sign out',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ))
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
