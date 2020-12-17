import 'package:flutter/material.dart';
import 'task_tile.dart';

import 'package:provider/provider.dart';
import 'package:todoey_app/data.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {


  @override
  Widget build(BuildContext context) {
    Data _dataProvider = Provider.of<Data>(context);

    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
            taskTitle: _dataProvider.getTask(index).name,
            isChecked: _dataProvider.getTask(index).isDone,
            checkboxCallback: (checkboxState) {
              setState(() {
                _dataProvider.getTask(index).toggleDone();
              });
            });
      },
      itemCount: _dataProvider.getTotalTasks(),
    );
  }
}