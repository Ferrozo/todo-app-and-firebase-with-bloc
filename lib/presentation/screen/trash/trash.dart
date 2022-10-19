import 'package:flutter/material.dart';
import '../left_bar/left_bar.dart';

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
