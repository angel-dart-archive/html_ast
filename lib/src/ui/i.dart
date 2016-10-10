import '../element.dart';
import '../state.dart';

ItalicElement i(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new ItalicElement(state, props, children);

class ItalicElement extends StandardElement {
  ItalicElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('i', state, props ?? {}, children);
}
