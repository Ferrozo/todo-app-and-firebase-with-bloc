import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app_with_firebase/presentation/screen/home/home_page.dart';
// import 'package:local_storage_todos_api/local_storage_todos_api.dart';
// import 'package:todo_app_with_firebase/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}
