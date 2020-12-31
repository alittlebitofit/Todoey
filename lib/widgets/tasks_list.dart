import 'package:flutter/material.dart';
import 'package:todoey_app/screens/add_task_screen.dart';
import 'task_tile.dart';

import 'package:provider/provider.dart';
import 'package:todoey_app/models/task_data.dart';

import 'package:todoey_app/models/task_enum.dart';

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
                taskData.updateCheckbox(index);
              },
              onLongPressCallback: () {
                taskData.deleteTask(index);
              },
              onTap: () {
                print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~tapped');
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      child:
                      AddTaskScreen(taskEnum: TaskEnum.EDIT, index: index, taskString: taskData.getTask(index).name),
                    ),
                  ),
                );
              }
            );
          },
          itemCount: taskData.tasksCount,
        );
      },
    );
  }
}