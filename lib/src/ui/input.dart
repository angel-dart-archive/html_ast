import 'package:heaven/heaven.dart';

InputElement input(State state,
    {Iterable<Element<Map<String, dynamic>, State>> children: const [],
    num max,
    num min,
    String name,
    String placeholder,
    Map<String, dynamic> props: const {},
    bool required: false,
    num step,
    String type: 'text',
    String value}) {
  final properties = {}..addAll(props);

  if (max != null) properties['max'] = max;
  if (min != null) properties['min'] = min;
  if (name != null) properties['name'] = name;
  if (placeholder != null) properties['placeholder'] = placeholder;
  if (required != null) properties['required'] = required;
  if (step != null) properties['step'] = step;
  if (type != null) properties['type'] = type;
  if (value != null) properties['value'] = value;

  return new InputElement(state, properties, children);
}

class InputElement extends StandardElement {
  InputElement(State state,
      [Map<String, dynamic> props,
      Iterable<Element<Map<String, dynamic>, State>> children])
      : super('input', state, props, children);

  @override get children => [];
}
