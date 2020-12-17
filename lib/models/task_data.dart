import 'package:flutter/material.dart';
import 'task.dart';

class Data extends ChangeNotifier {

  final List<Task> _tasksList = [];

  void addNewTask(String newTaskTitle){
    _tasksList.add(Task(name:newTaskTitle));
    notifyListeners();
  }

  Task getTask(int index){
    return _tasksList[index];
  }

  int get tasksCount => _tasksList.length;

  void updateCheckbox(int index){
    _tasksList[index].toggleDone();
    notifyListeners();
  }

  void deleteTask(int index){
    _tasksList.removeAt(index);
    notifyListeners();
  }

}