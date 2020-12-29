import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dog_class.dart';

class DatabaseClass {
  Future<Database> _database;

  // DatabaseClass._();
  DatabaseClass() {
    // _initiateDB();
  }
  
  // Future<Database> newDatabase() async {
  //   _database = await _databaseDemo();
  //   return _database;
  // }

  Future<void> initiateDB() async {

    if(_database != null) {
      print('already initiated');
      return;
    }

    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();

    // Open the database and store the reference.
    _database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'doggie_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        print('initiating ... ???');
        return db.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    print('initiating for first time');
  }

  Future<bool> insertDog(Dog dog) async {
    // Get a reference to the database.
    final Database db = await _database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.

    if (db == null) {
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      print('database is null in insertDog() in database_class.dart');
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      return false;
    }

    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print('new dog inserted in insertDog() in database_class.dart');
    return true;
  }

  Future<List<Map<String, dynamic>>> fetchAllDogsFromDB() async {
    // Get a reference to the database.
    final Database db = await _database;

    if(db == null) {
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      print('db is null in fetchAllDogsFromDB() in database_class.dart');
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      return null;
    }

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return maps;

    // // TODO
    // // BUT IT ALSO "CREATES" NEW DOGS - fix it
    // // Convert the List<Map<String, dynamic> into a List<Dog>.
    // return List.generate(maps.length, (i) {
    //   return Dog(
    //     // _id: maps[i]['id'],
    //     name: maps[i]['name'],
    //     age: maps[i]['age'],
    //   );
    // });
  }

  Future<bool> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await _database;

    if(db == null) {
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      print('db is null in updateDog() in database_class.dart');
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      return false;
    }

    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.getDogID()],
    );

    print('update seems to be successful so return true');
    return true;
  }

  Future<bool> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await _database;

    if(db == null) {
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      print('db is null in deleteDog() in database_class.dart');
      print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      return false;
    }

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );

    return true;

  }

  // void test() async {
  //   var fido = Dog(
  //     name: 'Fido',
  //     age: 35,
  //   );
  //
  //   // Insert a dog into the database.
  //   await insertDog(fido);
  //
  //   // Print the list of dogs (only Fido for now).
  //   print(await fetchAllDogs());
  //
  //   // Update Fido's age and save it to the database.
  //   fido.updateDogAge(newAge: (fido.getDogAge() + 7));
  //
  //   // = Dog(
  //   //   name: fido._name,
  //   //   age: fido._age + 7,
  //   // );
  //
  //   // await updateDog(fido);
  //
  //   // Print Fido's updated information.
  //   print(await fetchAllDogs());
  //
  //   // Delete Fido from the database.
  //   // await deleteDog(fido._id);
  //
  //   // Print the list of dogs (empty).
  //   print(await fetchAllDogs());
  // }
}
