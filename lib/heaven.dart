/// A React-inspired virtual DOM implementation.
library heaven;

import 'dart:async';
import 'dart:html' as html;

part 'src/state.dart';

/// Controls a virtual DOM within the context of one root element.
class DOM {
  static html.Element _domRoot;
  static Element _parent;
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
    html.Element rerendered = rerenderElem(_parent);
    _domRoot.children
      ..clear()
      ..add(rerendered);
  }

  static html.Element rerenderElem(Element element) {
    if (!element.shouldUpdate(priorState, state)) {
      return html.document.querySelector("[data-heaven-id='${element._id}']");
    }

    return renderElem(element);
  }

  static html.Element renderElem(Element element,
      {bool incrementRendered: false}) {
    if (incrementRendered)
      element._id = _nRendered++;

    element..state = state;
    element.preRender();
    html.Element result = html.document.createElement(element.tagName);

    for (String key in element.requiredKeys) {
      if (_rgxArray.hasMatch(key)) {
        String _key = key.replaceAll(_rgxArray, "");
        var value = state.get(_key);
        if (value == null)
          state.set(_key, []);
      } else {
        var value = state.get(key);
        if (value == null)
          state.set(key, {});
      }
    }

    for (String key in element.properties.keys) {
      var value = element.properties[key];

      if (key == "className")
        result.className = value.toString();
      else result.setAttribute(key, value.toString());
    }

    if (element.children.isNotEmpty) {
      for (Element child in element.children) {
        result.children.add(
            renderElem(child, incrementRendered: incrementRendered));
      }
    }

    if (element.innerHtml.isNotEmpty)
      result.innerHtml = element.innerHtml;
    else if (element.text.isNotEmpty)
      result.appendText(element.text);

    element.afterRender(
        result..setAttribute("data-heaven-id", element._id.toString()));
    return result;
  }

  static void _onStateChange(StateUpdateEvent e) {
    priorState = new State.copy(state);
    Map parent = state.resolveParent_(e.path);
    parent[state.lastKey_(e.path)] = e.value;

    if (e.rerender)
      rerenderDom();
  }

  static void init(Element parent, html.Element domRoot) {
    _domRoot = domRoot;
    _parent = parent;
    state.onUpdate.listen(_onStateChange);
  }
}

/// Represents a virtual DOM node.
class Element {
  int _id;

  /// This element's tag name.
  String tagName;

  /// A dynamic set of properties that will be mapped to HTML attributes.
  Map<String, dynamic> properties;
  List<Element> children;

  /// If set, will override children and text, and set the rendered element's inner HTML.
  String innerHtml;

  /// Inner text to be appended to the element.
  String text;


  Map propTypes = null;

  /// Any number of required keys/dot paths that the application state must have to render this component.
  List<String> requiredKeys = [];

  /// The current state of the application.
  State state;

  Element({String this.tagName: "div",
  Map<String, dynamic> this.properties,
  List<Element> this.children,
  String this.innerHtml: "",
  String this.text: ""}) {
    if (properties == null)
      properties = {};
    if (children == null)
      children = [];
  }

  /// Called after the element has been rendered to a DOM node.
  afterRender(html.Element elem) {
  }

  /// Called before the element is rendered.
  ///
  /// If you modify the application state, make sure to pass
  /// `rerender: false`.
  preRender() {

  }

  /// Called before preRender, to determine whether the element should re-render.
  bool shouldUpdate(State priorState, State currentState) {
    return true;
  }
}
