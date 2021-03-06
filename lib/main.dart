import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff00d7f3)
      ),
      home: TodoListPage(),
    );
  }
}

