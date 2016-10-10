import '../element.dart';
import '../state.dart';

DivElement div(State state,
        [Map<String, dynamic> props,
        List<Element<Map<String, dynamic>, State>> children]) =>
    new DivElement(state, props, children);

class DivElement extends StandardElement {
  DivElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('div', state, props ?? {}, children);
}
