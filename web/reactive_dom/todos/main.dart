import 'dart:async';
import 'dart:html' as html;
import 'package:heaven/heaven.dart';
import 'package:heaven/reactive_dom.dart';
import 'src/app.dart';

main() {
  final container = html.window.document.getElementById('app');
  final controller = new StreamController<State>.broadcast();

  addTodo(State state, String text) {
    controller.add(new State.fromMap({
      'todos': []
        ..addAll(state.todos)
        ..add(text)
    }));
  }

  // TL;DR - Pass addTodo as a property, the only way to do any type of
  // state modification
  new ReactiveDomRenderer(controller.stream)
    ..render((state) => new TodoApp(state, addTodo), container);

  controller.stream.listen((state) {
    print('Updated state: ${state.dump()}');
  });

  controller.add(new State.fromMap({'todos': []}));
}
