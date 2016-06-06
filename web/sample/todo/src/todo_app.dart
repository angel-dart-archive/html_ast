part of todo;

class TodoApp extends HeavenElement {
  @override
  void afterRender(Element elem) {
    InputElement input = elem.querySelector('input');
    FormElement form = elem.querySelector('form');

    form.onSubmit.listen((e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      e.stopPropagation();

      if (input.value.isNotEmpty)
        state.append('todos', new Todo(state['todos'].length, input.value));
    });
  }

  @override
  String render() {
    return '''
    <div class="ui header">Todos (${state['todos'].length})</div>
    <ul class="ui middle aligned divided list">
      ${state['todos'].map((Todo todo) {
        return new TodoItem(todo);
      }).join()}
    </ul>
    <form>
    <div class="ui fluid action input">
      <input placeholder="What needs to be done?" type="text" />
      <button class="ui teal button" type="submit">
          <i class="plus icon"></i>
          Add
        </div>
      </button>
    </form>
    ''';
  }
}
