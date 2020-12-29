import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'database_class.dart';

class Dog {
  static int _dogNumber = 0;

  static DatabaseClass _dataBaseClass = DatabaseClass();

  // Future<Database> db;

  static final List<Dog> _existingDogsList = [];

  int _id;
  String _name;
  int _age;

  Dog({@required String name, int age}) {
    _dogNumber++;
    this._id = _dogNumber;
    this._name = name;
    this._age = age;
    // db = _dataBaseClass.newDatabase();
    // _existingDogsList.add(this);
    // _insertDog();
  }

  Future<void> _initiate() async {
    await _dataBaseClass.initiateDB();
  }

  Future<void> insertDog() async {
    await _initiate();
    if (await _dataBaseClass.insertDog(this)) {
      _existingDogsList.add(this);
      print('Dog inserted with id ${this._id}');
    } else {
      print('Dog not inserted');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'age': _age,
    };
  }

  Future<List<Dog>> fetchAllDogs() async {
    List<Map<String, dynamic>> maps = await _dataBaseClass.fetchAllDogsFromDB();

    if (maps == null) {
      print('maps is null in fetchAllDogs() in dog_class.dart');
      return null;
    }

    print('maps is not null &&&&&&');
    int _loopCounter = 0;

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    // return
    final List<Dog> _listOfDogs = List.generate(maps.length, (i) {
      _loopCounter++;

      final int _existingDogID = maps[i]['id'];

      Dog _dogToReturn;

      for (Dog _dog in _existingDogsList) {
        if (_dog == null) {
          print('_dog is null so continue $_loopCounter');
          // _existingDogsList.remove(_dog);
          continue;
        }
        if (_dog.getDogID() == _existingDogID) {
          _dogToReturn = _dog;
          print('since dog found, dog is $_dog');
          break;
        }
      }

      // print('dog number $_existingDogID found but _dogToReturn is: $_dogToReturn');
      if(_dogToReturn == null) {
        // continue;
        // TODO
        // how to not insert dogs that are null?
      }
      return _dogToReturn;

      // return Dog(
      //   // _id: maps[i]['id'],
      //   name: maps[i]['name'],
      //   age: maps[i]['age'],
      // );
    });

    print('total loops : $_loopCounter');

    int _anotherLoopCounter = 0;

    for(Dog _dog in _listOfDogs.toList()) {
      _anotherLoopCounter++;
      if(_dog == null) {
        // print('remove this dog $_anotherLoopCounter in a for loop because it is null');
        _listOfDogs.remove(_dog);
      }
    }

    print('_anotherLoopCounter: $_anotherLoopCounter');

    return _listOfDogs;
  }

  Future<void> updateDogName({@required String newName}) async {
    final String _tempOldName = _name;
    _name = newName;
    if(await _dataBaseClass.updateDog(this)){
      print('update with $newName successful');
    } else {
      print('$newName couldn\'t be updated');
      _name = _tempOldName;
    }

  }

  Future<void> updateDogAge({@required int newAge}) async {
    final int _tempOldAge = _age;
    _age = newAge;
    if(await _dataBaseClass.updateDog(this)){
      print('update with $newAge successful');
    } else {
      print('$newAge couldn\'t be updated');
      _age = _tempOldAge;
    }
  }

  int getDogAge() => _age;
  String getDogName() => _name;
  int getDogID() => _id;

  Future<void> deleteDog() async {
    if(await _dataBaseClass.deleteDog(this._id)) {
      print('delete seems successful so deleting this');
      _existingDogsList.remove(this);
    } else {
      print('failed to delete dog for some reason');
    }
  }

  // TODO
  // return existing dog, but how? -> by keeping track of existing dogs' IDs
  // but even then that list of IDs wouldn't be persistent
  // maybe i should fetch the ids separately too
  // but later, first implement basic stuff

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $_id, name: $_name, age: $_age}';
  }
}
