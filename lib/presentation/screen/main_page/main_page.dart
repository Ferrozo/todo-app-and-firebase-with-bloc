import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc/auth_bloc.dart';
import '../../../bloc/bloc/auth_event.dart';
import '../../../bloc/bloc/auth_state.dart';
import '../sign_in/sign_in.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showCurrentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: const Color(0xFF181920),
      appBar: AppBar(
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
            children: [
              showCurrentUser.photoURL != null
                  ? CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      child: Image.network(
                        '${showCurrentUser.photoURL}',
                      ))
                  : Container(),
              IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOutRequested());
                  },
                  icon: const Icon(Icons.output_rounded))
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
        child: Center(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
