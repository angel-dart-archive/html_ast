import '../element.dart';
import '../state.dart';

H1Element h1(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new H1Element(state, props, children);

H2Element h2(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new H2Element(state, props, children);

H3Element h3(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new H3Element(state, props, children);

H4Element h4(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new H4Element(state, props, children);

H5Element h5(State state,
    [Map<String, dynamic> props,
    List<Element<Map<String, dynamic>, State>> children]) =>
    new H5Element(state, props, children);

abstract class HeaderElement {}

class H1Element extends StandardElement
    implements HeaderElement {
  H1Element(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('h1', state, props ?? {}, children);
}

class H2Element extends StandardElement implements HeaderElement{
  H2Element(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('h2', state, props ?? {}, children);
}

class H3Element extends StandardElement implements HeaderElement{
  H3Element(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('h3', state, props ?? {}, children);
}

class H4Element extends StandardElement implements HeaderElement{
  H4Element(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('h4', state, props ?? {}, children);
}

class H5Element extends StandardElement implements HeaderElement{
  H5Element(State state, Map<String, dynamic> props,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('h5', state, props ?? {}, children);
}
