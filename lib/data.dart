import 'package:flutter/material.dart';
import 'models/task.dart';

class Data extends ChangeNotifier {

  final List<Task> _tasksList = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy chocolate'),
    Task(name: 'Buy chips'),
  ];

  void addNewTask(String newTaskTitle){
    _tasksList.add(Task(name:newTaskTitle));
    notifyListeners();
  }

  Task getTask(int index){
    return _tasksList[index];
  }

  int getTotalTasks(){
    return _tasksList.length;
  }
}