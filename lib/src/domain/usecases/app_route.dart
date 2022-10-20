import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/src/presentation/screen/main_page/main_page.dart';
import 'package:todo_app_with_firebase/src/presentation/screen/trash/trash.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Trash.id:
        return MaterialPageRoute(builder: (_) => const Trash());
      case MainPage.id:
        return MaterialPageRoute(builder: (_) => const MainPage());
      default:
        return null;
    }
  }
}
