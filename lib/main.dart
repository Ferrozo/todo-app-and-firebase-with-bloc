import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app_with_firebase/presentation/screen/home/home_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_bloc_observer.dart';
import 'blocs/blocs/tasks_bloc.dart';
import 'models/task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(BlocProvider(
    create: (context) => TasksBloc()..add(AddTask(task: Task(title: 'Todo 1'))),
    child: const HomePage(),
  ));
}
