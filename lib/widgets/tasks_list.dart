import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:todoey_app/models/task.dart';

class TasksList extends StatefulWidget {

  TasksList({this.tasksList});
  final List<Task> tasksList;

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
            taskTitle: widget.tasksList[index].name,
            isChecked: widget.tasksList[index].isDone,
            checkboxCallback: (checkboxState) {
              setState(() {
                widget.tasksList[index].toggleDone();
              });
            });
      },
      itemCount: widget.tasksList.length,
    );
  }
}
