class Task {
  Task({this.name, this.isDone = false});

  final String name;
  bool isDone;

  void toggleDone(){
    isDone = !isDone;
  }

  Task.fromMap(Map map):
      this.name = map['name'],
      this.isDone = map['isDone'];

  Map toMap(){
    return {
      'name': this.name,
      'isDone': this.isDone,
    };
  }

}