part of todo;

class TodoItem extends HeavenElement {
  Todo todo;

  TodoItem(Todo this.todo) {}

  @override
  afterRender(Element elem) {
    DivElement button = elem.querySelector('.ui.button');
    button.onClick.listen((_) {
      print("Hey");
      if (window.confirm("Remove todo \"${todo.text}\"?")) {
        state['todos'] = state['todos'].removeWhere((Todo todo) {
          return todo.ID == this.todo.ID;
        });
      }
    });
  }

  @override
  String render() {
    return '''
    <div class="item">
      <div class="right floated content">
        <div class="ui button">
          <i class="remove icon"></i>
          Remove
        </div>
      </div>
      ${todo.done ? '<div class="ui label"><i class="check icon"></i>Complete</div>' : ""}
      <div class="content">
        ${todo.text}
      </div>
    </div>
    ''';
  }
}
