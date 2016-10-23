import '../element.dart';
import '../state.dart';

LinkElement link(State state,
    {Iterable<Element<Map<String, dynamic>, State>> children: const [],
    String href,
    Map<String, dynamic> props: const {},
    String rel}) {
  final properties = {}..addAll(props);

  if (href != null)
    properties['href'] = href;
  if (rel != null)
    properties['rel'] = rel;

  return new LinkElement(state, properties);
}

class LinkElement extends StandardElement {
  LinkElement(State state,
      [Map<String, dynamic> props])
      : super('link', state, props, []);

  @override
  String render() =>
      '<$tagName ${('' + concatProps()).trim()}>';
}
