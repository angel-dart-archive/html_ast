import '../element.dart';
import '../state.dart';

TitleElement title(State state,
    [List<Element<Map<String, dynamic>, State>> children]) =>
    new TitleElement(state, {}, children);

class TitleElement extends StandardElement {
  TitleElement(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('title', state, props ?? {}, children);
}
