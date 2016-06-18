library playground;

import 'dart:async';
import 'dart:html';
import 'package:heaven/heaven.dart' as heaven;

class Button extends heaven.Element {
  String get innerHtml => '''
  <div class="ui button">
    <i class="smile icon"></i>
    Click me!
  </div>
  ''';

  @override
  Future afterRender(Element elem) async {
    elem
        .querySelector(".ui.button")
        .onClick
        .listen((_) {
      state["clicks"] = state["clicks"] + 1;
    });
  }
}

class CookieClicker extends heaven.Element {
  List<String> requiredKeys = ["clicks"];

  List<heaven.Element> children = [new Button()];

  String get text => "${state.get("clicks")} clicks";
}

main() {
  heaven.DOM.state.set("clicks", 0);
  heaven.DOM.init(new CookieClicker(), document.getElementById("app"));
}