part of chat;

class MessageView extends HeavenElement {
  ChatMessage message;

  MessageView(ChatMessage this.message);

  @override
  render() {
    return '''
    <div class="comment">
      <a class="avatar">
        <i class="user icon"></i>
      </a>
      <div class="content">
        <a class="author">${message.userName}</a>
        <div class="metadata">
          <span class="date">Just now</span>
        </div>
      </div>
      <div class="text">${message.text}</div>
    </div>
    ''';
  }
}
