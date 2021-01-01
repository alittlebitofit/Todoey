import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile({this.taskTitle, this.isChecked, this.checkboxCallback, this.onTap});

  final String taskTitle;
  final bool isChecked;
  final Function checkboxCallback;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
          fontSize: 20,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
      onTap: onTap,
    );
  }
}