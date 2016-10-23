import '../element.dart';
import '../state.dart';

BodyElement body(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new BodyElement(state, props, children);

class BodyElement extends StandardElement {
  BodyElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('body', state, props ?? {}, children);
}
