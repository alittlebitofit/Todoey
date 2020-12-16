import 'package:flutter/material.dart';
import 'package:todoey_app/screens/tasks_screen.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('hi');
    return MaterialApp(
      home: TasksScreen(),
    );
  }
}
