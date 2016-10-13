import 'dart:html' as html;
import 'package:heaven/heaven.dart';
import 'package:heaven/ui.dart';
import 'add_todo.dart';

class TodoForm extends StandardElement {
  final AddTodo addTodo;

  TodoForm(State state, this.addTodo, [Map<String, dynamic> props])
      : super('todo-form', state, props);

  @override
  get children {
    return [
      form(state, children: [
        input(state,
            name: 'text', placeholder: 'Add a Todo...', required: true),
        input(state, type: 'submit', value: 'Submit')
      ])
    ];
  }

  @override
  void afterRender(html.Element $root) {
    final html.FormElement $form = $root.querySelector('form');
    final html.InputElement $input = $root.querySelector('input');

    $form.onSubmit.listen((e) {
      e.preventDefault();

      if ($input.value.isNotEmpty) {
        addTodo(state, $input.value);
        $input.focus();
      }
    });
  }

  @override
  bool shouldUpdate(_) => false;

  @override
  bool shouldUpdateChild(_, __) => false;
}
