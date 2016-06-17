/// A React-inspired virtual DOM implementation.
///
/// Includes integrations with Angel.
library heaven;

import 'dart:async';
import 'dart:html';

part 'src/state.dart';

class DOM {
  static Element _domRoot;
  static VirtualDOMElement _parent;
  static int _nRendered = 0;

  static final RegExp _rgxArray = new RegExp(r"^\[\]");
  static State priorState;
  static State state = new State();

  static void renderDom() {
    _nRendered = 0;
    _domRoot.children
      ..clear()
      ..add(renderElem(_parent, incrementRendered: true));
  }

  static void rerenderDom() {
    // Remember: shouldUpdate, etc.
    Element rerendered = rerenderElem(_parent);
    _domRoot.children..clear()..add(rerendered);
  }

  static Element rerenderElem(VirtualDOMElement element) {
    if (!element.shouldUpdate(priorState, state)) {
      return document.querySelector("[data-heaven-id='${element.id}']");
    }

    return renderElem(element);
  }

  static Element renderElem(VirtualDOMElement element,
      {bool incrementRendered: false}) {
    if (incrementRendered)
      element.id = _nRendered++;

    element..state = state;
    Element result = document.createElement(element.tagName);

    for (String key in element.requiredKeys) {
      if (_rgxArray.hasMatch(key)) {
        String _key = key.replaceAll(_rgxArray, "");
        var value = state.get(key);
        if (value == null)
          state.set(key, []);
      } else {
        var value = state.get(key);
        if (value == null)
          state.set(key, {});
      }
    }

    for (String key in element.properties.keys) {
      var value = element.properties[key];

      if (value is String) {
        if (key == "className")
          result.className = value;
        else result.setAttribute(key, value);
      }
    }

    if (element.children.isNotEmpty) {
      for (VirtualDOMElement child in element.children) {
        result.children.add(
            renderElem(child, incrementRendered: incrementRendered));
      }
    }

    if (element.innerHtml.isNotEmpty)
      result.innerHtml = element.innerHtml;
    else if (element.text.isNotEmpty)
      result.appendText(element.text);

    element.afterRender(
        result..setAttribute("data-heaven-id", element.id.toString()));
    return result;
  }

  static void _onStateChange(StateUpdateEvent e) {
    priorState = new State.copy(state);
    Map parent = state.resolveParent_(e.path);
    parent[state.lastKey_(e.path)] = e.value;

    rerenderDom();
  }

  static void init(VirtualDOMElement parent, Element domRoot) {
    _domRoot = domRoot;
    _parent = parent;
    state.onUpdate.listen(_onStateChange);
  }
}

class VirtualDOMElement {
  int id;
  String tagName;
  Map<String, dynamic> properties;
  List<VirtualDOMElement> children;
  String innerHtml;
  String text;

  List<String> requiredKeys = [];
  State state;

  VirtualDOMElement({String this.tagName: "div",
  Map<String, dynamic> this.properties: const {},
  List<VirtualDOMElement> this.children: const [],
  String this.innerHtml: "",
  String this.text: ""});

  afterRender(Element elem) {

  }

  bool shouldUpdate(State priorState, State currentState) {
    return true;
  }
}
