import 'package:heaven/heaven.dart';
import 'package:heaven/ui.dart';
import 'add_todo.dart';
import 'form.dart';

class TodoApp extends StandardElement {
  final AddTodo addTodo;

  TodoApp(State state, this.addTodo, [Map<String, dynamic> props]) : super('div', state, props);

  @override
  get children {
    return [
      h1(state, {
        'style': {'color': 'orange'}
      }, [
        text('${state.todos.length} Todo(s)')
      ]),
      ul(
          state,
          {},
          state.todos
              .where((todo) => todo.isNotEmpty)
              .map((todo) => li(state, {}, [text(todo)]))),
      new TodoForm(state, addTodo)
    ];
  }
}
