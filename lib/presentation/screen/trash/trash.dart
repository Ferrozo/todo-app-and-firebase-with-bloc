import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs/auth_bloc.dart';
import '../../../blocs/blocs/auth_event.dart';
import '../../../blocs/blocs/auth_state.dart';
import '../../widgets/todo_list.dart';
import '../left_bar/left_bar.dart';
import '../sign_in/sign_in.dart';

class Trash extends StatelessWidget {
  const Trash({Key? key}) : super(key: key);

  static const id = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181920),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Trash'),
      ),
      drawer: const LeftBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
            child: Chip(label: Text('0')),
          ),
        ],
      ),
    );
  }
}
