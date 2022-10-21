import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/domain/usecases/app_route.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/screen/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp();
  HydratedBlocOverrides.runZoned(
    () => runApp(
      // ignore: prefer_const_constructors
      BlocProvider(
        create: (context) => TasksBloc(),
        child: HomePage(
          appRouter: AppRouter(),
        ),
      ),
    ),
    storage: storage,
  );
}
