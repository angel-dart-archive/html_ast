import '../element.dart';
import '../state.dart';

MetaElement meta(State state,
    {Iterable<Element<Map<String, dynamic>, State>> children: const [],
    Map<String, dynamic> props: const {},
    String name}) {
  final properties = {}..addAll(props);

  if (name != null)
    properties['name'] = name;

  return new MetaElement(state, properties);
}

class MetaElement extends StandardElement {
  MetaElement(State state,
      [Map<String, dynamic> props])
      : super('meta', state, props, []);

  @override
  String render() =>
      '<$tagName ${('' + concatProps()).trim()}>';
}
