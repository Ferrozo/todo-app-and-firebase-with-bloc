import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/bloc/auth_bloc.dart';
import '../../../bloc/bloc/auth_event.dart';
import '../../../bloc/bloc/auth_state.dart';
import '../main_page/main_page.dart';
import '../sign_up/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(
            email: _emailController.text, password: _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error.toString())));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UnAuthenticated) {
              return Container();
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sign In'),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  hintText: 'password',
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? 'Enter a stronger password'
                                      : null;
                                },
                              ),
                              SizedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _authenticateWithEmailAndPassword(context);
                                  },
                                  child: const Text('Sign In'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _authenticateWithGoogle(context);
                        },
                        icon: const Icon(
                          Icons.ac_unit_sharp,
                        ),
                      ),
                      const Text('Don\'t have an account?'),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
            );
            // ignore: dead_code
            return Container();
          },
        ),
      ),
    );
  }
}
