import '../element.dart';
import '../state.dart';

DocumentElement document(State state,
        [List<Element<Map<String, dynamic>, State>> children]) =>
    new DocumentElement(state, 'html', children);

class DocumentElement extends StandardElement {
  final String doctype;

  DocumentElement(State state, this.doctype,
      [List<Element<Map<String, dynamic>, State>> children])
      : super('div', state, {}, children);

  @override
  String render() =>
      '<!DOCTYPE $doctype>${children.map((child) => child.render()).join()}';
}
