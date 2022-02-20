import 'package:flutter/material.dart';
import 'package:flutter_famfam/screens/components/body.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TodoBody(),
    );
  }
}
