import '../element.dart';
import '../state.dart';

ParagraphElement p(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new ParagraphElement(state, props, children);

class ParagraphElement extends StandardElement {
  ParagraphElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('p', state, props ?? {}, children);
}
