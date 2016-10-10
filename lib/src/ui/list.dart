import '../element.dart';
import '../state.dart';

UListElement ul(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new UListElement(state, props, children);

OListElement ol(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new OListElement(state, props, children);

ListItemElement li(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new ListItemElement(state, props, children);

class UListElement extends StandardElement {
  UListElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('ul', state, props ?? {}, children);
}


class OListElement extends StandardElement {
  OListElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('ol', state, props ?? {}, children);
}

class ListItemElement extends StandardElement {
  ListItemElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('li', state, props ?? {}, children);
}
