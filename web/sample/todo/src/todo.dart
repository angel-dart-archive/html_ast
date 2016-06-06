part of todo;

class Todo {
  int ID;
  String text;
  bool done;

  Todo(int this.ID, String this.text, [bool done]) {
    this.done = done ?? false;
  }
}
