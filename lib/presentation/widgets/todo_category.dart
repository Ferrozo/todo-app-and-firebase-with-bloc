import 'package:flutter/material.dart';

class TodoCategory extends StatelessWidget {
  const TodoCategory(
      {Key? key, required this.categoryTitle, required this.numberOfTasks})
      : super(key: key);

  final String categoryTitle;
  final int numberOfTasks;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(20),
      height: 115,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.indigo[800],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${numberOfTasks.toString()} tasks',
            style: TextStyle(
              color: Colors.grey.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            categoryTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
