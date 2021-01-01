import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoey_app/widgets/tasks_list.dart';
import 'add_task_screen.dart';

import 'package:provider/provider.dart';
import 'package:todoey_app/models/task_data.dart';

import 'package:fullscreen/fullscreen.dart';

class TasksScreen extends StatelessWidget {
  final FullScreen fullscreen = new FullScreen();

  void enterFullScreen(FullScreenMode fullScreenMode) async {
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~entering full screen');
    await fullscreen.enterFullScreen(fullScreenMode);
  }

  void exitFullScreen() async {
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~exiting full screen');
    await fullscreen.exitFullScreen();
  }

  @override
  Widget build(BuildContext context) {
    // enterFullScreen(FullScreenMode.EMERSIVE_STICKY);

    Data _dataProvider = Provider.of<Data>(context);
    SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      // primary: false,
      // resizeToAvoidBottomPadding: false,
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      // endDrawerEnableOpenDragGesture: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                child: AddTaskScreen(),
              ),
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 60.0,
              left: 30,
              right: 30,
              bottom: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.list,
                        size: 40,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Todoey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${_dataProvider.tasksCount} ${_dataProvider.tasksCount != 1 ? "Tasks" : "Task"}',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    print('Delete');
                    // _dataProvider.deleteAllTasks();
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Empty list?'),
                        content: Text('This would delete all tasks.'),
                        actions: [
                          FlatButton(
                            child: Text(
                              'No',
                            ),
                            onPressed: () {
                              print('No was pressed');
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text(
                              'Yes',
                            ),
                            onPressed: () {
                              print('Yes was pressed');
                              _dataProvider.deleteAllTasks();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        elevation: 24,
                      ),
                      // barrierDismissible: false,
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              child: TasksList(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
