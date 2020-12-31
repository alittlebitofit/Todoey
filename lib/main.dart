import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'Scratch/scratch.dart';

import 'package:todoey_app/screens/tasks_screen.dart';
import 'models/task_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}