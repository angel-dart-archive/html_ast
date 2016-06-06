library chat;

import 'dart:convert' show JSON;
import 'dart:html';
import 'package:heaven/heaven.dart';

part 'src/chat_app.dart';
part 'src/chat_message.dart';
part 'src/message_view.dart';

main() {
  String userName = 'Heavenly';
  WebSocket ws = new WebSocket("ws://echo.websocket.org");

  ws.onOpen.listen((_) {
    Heaven heaven =
        new Heaven(new ChatApp(userName, ws), document.getElementById('app'));
    heaven.state['messages'] = [];
    ws.onMessage.listen((MessageEvent e) {
      Map data = JSON.decode(e.data);
      heaven.state
          .append('messages', new ChatMessage(data['userName'], data['text']));
    });

    heaven.renderDom();
  });
}
