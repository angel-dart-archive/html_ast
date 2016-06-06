library todo;

import 'dart:html';
import 'package:heaven/heaven.dart';

part 'src/todo.dart';
part 'src/todo_app.dart';
part 'src/todo_item.dart';

main() {
  Heaven heaven = new Heaven(new TodoApp(), document.getElementById('app'));
  heaven.state['todos'] = [
    new Todo(0, "Fuck bitches"),
    new Todo(1, "Get money")
  ];
  heaven.renderDom();
}
