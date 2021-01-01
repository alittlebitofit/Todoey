import 'dart:convert';

import 'package:flutter/material.dart';
import 'task.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Data extends ChangeNotifier {
  List<Task> _tasksList = [];
  SharedPreferences _sharedPreferences;

  Data() {
    initSharedPreferences();
  }

  initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _loadData();
  }

  void _saveData() {
    List<String> _spList =
        _tasksList.map((item) => jsonEncode(item.toMap())).toList();
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ $_spList');
    _sharedPreferences.setStringList('_tasksList', _spList);
    notifyListeners();
  }

  void _loadData() {
    List<String> _spList = _sharedPreferences.getStringList('_tasksList');
    _tasksList = _spList.map((item) => Task.fromMap(jsonDecode(item))).toList();
    notifyListeners();
  }

  int get tasksCount => _tasksList.length;

  Task getTask(int index) {
    return _tasksList[index];
  }

  void addNewTask(String newTaskTitle) {
    _tasksList.add(Task(name: newTaskTitle));
    _saveData();
  }

  void editTask({@required String newTitle, @required int index}) {
    _tasksList[index].name = newTitle;
    _saveData();
  }

  void updateCheckbox(int index) {
    _tasksList[index].toggleDone();
    _saveData();
  }

  void deleteTask(int index) {
    _tasksList.removeAt(index);
    _saveData();
  }

  void undoDeletion(int index, Task item) {
    _tasksList.insert(index, item);
    _saveData();
  }

  void deleteAllTasks() {
    _tasksList.clear();
    _saveData();
  }
}
