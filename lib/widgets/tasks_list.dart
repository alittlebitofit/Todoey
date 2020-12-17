import 'package:flutter/material.dart';
import 'task_tile.dart';

import 'package:provider/provider.dart';
import 'package:todoey_app/models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              taskTitle: taskData.getTask(index).name,
              isChecked: taskData.getTask(index).isDone,
              checkboxCallback: (someValue) {
                taskData.checkOff(index);
              },
              onLongPressCallback: () {
                taskData.deleteTask(index);
              },
            );
          },
          itemCount: taskData.tasksCount,
        );
      },
    );
  }
}