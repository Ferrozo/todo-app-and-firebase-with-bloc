import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/auth_state.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks_bloc.dart';
import '../main_page/main_page.dart';
import '../sign_in/sign_in.dart';
import '../trash/trash.dart';

class LeftBar extends StatefulWidget {
  const LeftBar({Key? key}) : super(key: key);

  @override
  State<LeftBar> createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> {
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
              onTap: () => Navigator.of(context).pushNamed(MainPage.id),
              child: Drawer(
                width: 240,
                backgroundColor: Colors.indigo[800],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 50),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
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
                    Text(
                      showCurrentUser.displayName ?? 'Dude',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed(MainPage.id),
                          child: ListTile(
                            leading: const Icon(Icons.folder),
                            title: const Text('All tasks'),
                            trailing: Text('${state.allTasks.length}'),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed(Trash.id),
                          child: ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Trash'),
                            trailing: Text('${state.removedTasks.length}'),
                          ),
                        );
                      },
                    ),
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
