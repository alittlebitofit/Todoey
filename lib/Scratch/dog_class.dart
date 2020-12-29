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
    _insertDog();
  }

  Future<void> _insertDog() async {
    if(await _dataBaseClass.insertDog(this)) {
      _existingDogsList.add(this);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'age': _age,
    };
  }

  Future<void> updateDogName({@required String newName}) async {
    _name = newName;
    await _dataBaseClass.updateDog(this);
  }

  Future<void> updateDogAge({@required int newAge}) async {
    _age = newAge;
    await _dataBaseClass.updateDog(this);
  }

  int getDogAge() => _age;

  int getDogID() => _id;

  Future<List<Dog>> fetchAllDogs() async {
    return await _dataBaseClass.fetchAllDogsFromDB();
  }

  Future<void> deleteDog() async {
    await _dataBaseClass.deleteDog(this._id);
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
