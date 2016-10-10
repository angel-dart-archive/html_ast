import 'dart:async' show Future;
import 'renderable.dart' show Renderable;
import 'state.dart';

typedef Element<P, S> ElementFactory<P, S>(P props, S state);

class StandardElement extends Element<Map<String, dynamic>, State> {
  StandardElement(String tagName, State state,
      [Map<String, dynamic> props,
      Iterable<Element<Map<String, dynamic>, State>> children])
      : super(tagName, state, props ?? {}, children);
}

/// A stateless class that produces a view in response to properties and a state.
class Element<P, S> implements Renderable<String> {
  int id;
  final List<Element<P, S>> children = [];
  final P props;
  final S state;
  final String tagName;

  Element(this.tagName, this.state, this.props,
      [Iterable<Element<P, S>> children]) {
    if (children != null) this.children.addAll(children);
  }

  void afterRender(elem) {}

  String concatProps() {
    final List<String> values = [];

    if (props is Map<String, dynamic>) {
      var _props = props;

      _props.forEach((String k, v) {
        values.add('$k="$v"');
      });
    }

    return values.join(' ');
  }

  @override
  String render() =>
      '<$tagName ${('' + concatProps()).trim()}>${children.map((child) => child.render()).join()}</$tagName>';

  @override
  Future<String> renderAsync() async {
    final children = await Future.forEach(
        this.children, (Element<P, S> elem) => elem.renderAsync());
    return '<$tagName>${children.join()}</$tagName>';
  }

  bool shouldUpdate(S nextState) => true;

  bool shouldUpdateChild(Element<Map<String, dynamic>, State> child, State state) => true;
}
