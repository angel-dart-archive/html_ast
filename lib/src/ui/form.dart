import 'package:heaven/heaven.dart';

FormElement form(State state,
    {String action,
    Iterable<Element<Map<String, dynamic>, State>> children: const [],
    String encType,
    String method,
    Map<String, dynamic> props: const {}}) {
  final properties = {}..addAll(props);

  if (action != null) properties['action'] = action;
  if (encType != null) properties['encType'] = encType;
  if (method != null) properties['method'] = method;

  return new FormElement(state, properties, children);
}

class FormElement extends StandardElement {
  FormElement(State state,
      [Map<String, dynamic> props,
      Iterable<Element<Map<String, dynamic>, State>> children])
      : super('form', state, props, children);
}
