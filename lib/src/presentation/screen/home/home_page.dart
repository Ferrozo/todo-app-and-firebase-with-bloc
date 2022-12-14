import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/src/domain/repositories/auth_repository.dart';
import 'package:todo_app_with_firebase/src/domain/usecases/app_route.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/blocs/dark_mode/dark_mode_bloc.dart';
import 'package:todo_app_with_firebase/src/presentation/theme/theme.dart';

import '../main_page/main_page.dart';
import '../sign_in/sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepository>(context),
                  )),
          BlocProvider(create: (context) => DarkModeBloc()),
        ],
        child: BlocBuilder<DarkModeBloc, DarkModeState>(
          builder: (context, state) {
            return MaterialApp(
              theme: state.isDarkMode
                  ? AppThemes.appThemeData[AppTheme.darkMode]
                  : AppThemes.appThemeData[AppTheme.lightMode],
              home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const MainPage();
                  }
                  return const SignIn();
                },
              ),
              onGenerateRoute: appRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
