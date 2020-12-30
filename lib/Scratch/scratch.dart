import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import 'package:todoey_app/widgets/tasks_list.dart';
import '../screens/add_task_screen.dart';

import 'package:provider/provider.dart';
import 'package:todoey_app/models/task_data.dart';

import 'dog_class.dart';

class TasksScreen extends StatelessWidget {



  void test() async {

    var fido = Dog(
      name: 'Fido',
      age: 35,
    );

    // Insert a dog into the database.
    await fido.insertDog();
    print('dog is inserted maybe?');

    // Print the list of dogs (only Fido for now).
    // print(await fido.fetchAllDogs());
    // await fido.fetchAllDogs();

    // Update Fido's age and save it to the database.
    await fido.updateDogName(newName: ('fido.getDogName()'));
    await fido.updateDogAge(newAge: (fido.age + 7));

    // = Dog(
    //   name: fido._name,
    //   age: fido._age + 7,
    // );

    // await updateDog(fido);

    // Print Fido's updated information.
    // print(await fido.fetchAllDogs());

    // Delete Fido from the database.
    // await fido.deleteDog();

    // Print the list of dogs (empty).
    // print(await fido.fetchAllDogs());

    // TODO
    // try calling fido again since its deleted
    print(await Dog.fetchAllDogs());
    // await fido.fetchAllDogs();

    // Dog.deleteAllDogs();

    // Dog.deleteDatabase();

  }


  @override
  Widget build(BuildContext context) {
    Data _dataProvider = Provider.of<Data>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
          print('FAB pressed');
          print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');



          var dogTask = await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) =>
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom,
                  ),
                  child: Container(
                    child: AddTaskScreen(),
                  ),
                ),
          );

          test();


          // if(dogTask.toString().isNotEmpty) {
          //   Dog newDog = Dog(name: dogTask);
          //   await newDog.insertDog();
          //   print('dogTask is inserted maybe twice?');
          //   print(await Dog.fetchAllDogs());
          // }
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 60.0,
                left: 30,
                right: 30,
                bottom: 30,
              ),
              child: Column(
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
                    '${_dataProvider.tasksCount} ${_dataProvider.tasksCount != 1
                        ? "Tasks"
                        : "Task"}',
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
      ),
    );
  }
}