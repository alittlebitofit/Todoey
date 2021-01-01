import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todoey_app/models/task_data.dart';
import 'package:todoey_app/models/task_enum.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen(
      {this.taskEnum = TaskEnum.ADD, this.index, this.taskString = ''});

  final TaskEnum taskEnum;
  final int index;
  final String taskString;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = taskString;

    // // for cursor to be placed at the end while editing
    // _textEditingController.selection = TextSelection.fromPosition(
    //   TextPosition(
    //     offset: _textEditingController.text.length,
    //   ),
    // );

    // text should be selected while editing
    _textEditingController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _textEditingController.text.length,
    );

    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  taskEnum == TaskEnum.ADD ? 'Add Task' : 'Edit Task',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                // TextFormField(
                //   // initialValue: taskString,
                //   controller: _textEditingController, // can't have both
                //   autofocus: true,
                //   textAlign: TextAlign.center,
                //   decoration: InputDecoration(
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.lightBlueAccent,
                //         width: 2,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    final task = _textEditingController.text;
                    if (task.isNotEmpty) {
                      if (taskEnum == TaskEnum.ADD) {
                        Provider.of<Data>(context, listen: false)
                            .addNewTask(task.trim());
                      } else if (taskEnum == TaskEnum.EDIT) {
                        Provider.of<Data>(context, listen: false)
                            .editTask(newTitle: task.trim(), index: index);
                      }
                    }

                    Navigator.pop(context);
                    // _textEditingController.dispose();
                  },
                  child: Text(
                    taskEnum == TaskEnum.ADD ? 'Add' : 'Save',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
