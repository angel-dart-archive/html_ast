part of chat;

class ChatApp extends HeavenElement {
  String lastText;
  String userName;
  WebSocket ws;

  ChatApp(String this.userName, WebSocket this.ws);

  String emptyState() {
    if (state['messages'] == null || state['messages'].isEmpty) {
      return '''
      <div class="ui error message">
        No messages here.
      </div>
      ''';
    } else
      return "";
  }

  @override
  afterRender(Element elem) {
    InputElement input = elem.querySelector('input');

    input
      ..value = lastText
      ..onKeyDown.listen((_) {
        // We're breaking a rule! Preserving the state of the
        // textbox, even after rendering...
        lastText = input.value;
      });

    FormElement form = elem.querySelector('form');
    form.onSubmit.listen((Event event) {
      event
        ..preventDefault()
        ..stopImmediatePropagation()
        ..stopPropagation();

      if (input.value.isNotEmpty) {
        ws.send(JSON.encode({'userName': userName, 'text': input.value}));
        input.value = "";
        lastText = "";
      }
    });
  }

  @override
  String render() {
    return '''
    <div class="ui comments">
      <h3 class="ui dividing header">
        <i class="comment icon"></i>
        Messages (${state['messages'].length})
      </h3>
      ${emptyState()}
      ${state['messages'].map((ChatMessage message) {
          return new MessageView(message);
      }).join()}
    </div>
    <form class="ui form">
      <div class="ui left icon action input">
        <i class="smile icon"></i>
        <input placeholder="Say something..." type="text" />
        <button class="ui button" type="submit">
          <i class="envelope icon"></i>
          Send
        </button>
      </div>
    </form>
    ''';
  }
}
