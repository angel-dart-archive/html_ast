import '../element.dart';
import '../state.dart';

HeadElement head(State state,
    [List<Element<Map<String, dynamic>, State>> children]) =>
    new HeadElement(state, {}, children);

class HeadElement extends StandardElement {
  HeadElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('head', state, props ?? {}, children);
}
