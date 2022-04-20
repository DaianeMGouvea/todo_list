import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({ Key? key, required this.todo, required this.onDeleted}) : super(key: key);

  final Todo todo;
  final Function(Todo) onDeleted;

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              label: 'Delete',
              backgroundColor: Colors.red,
              icon: Icons.delete,
              onPressed: (context) {
                onDeleted(todo);
              },
            ),
          ],
        ),
        child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  DateFormat('dd/MMM/yyyy - HH:mm').format(todo.datetime),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(todo.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold ,
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}