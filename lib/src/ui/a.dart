import '../element.dart';
import '../state.dart';

AnchorElement a(State state,
    {Iterable<Element<Map<String, dynamic>, State>> children: const [],
    String href,
    Map<String, dynamic> props: const {},
    String rel,
    String target}) {
  final properties = {}..addAll(props);
  
  if (href != null)
    properties['href'] = href;
  if (rel != null)
    properties['rel'] = rel;
  if (target != null)
    properties['target'] = target;
  
  return new AnchorElement(state, properties, children);
}

class AnchorElement extends StandardElement {
  AnchorElement(State state,
      [Map<String, dynamic> props,
      Iterable<Element<Map<String, dynamic>, State>> children])
      : super('a', state, props, children);
}
