import 'dart:async' show Future;
import '../element.dart';
import '../state.dart';

TextElement text(String text) => new TextElement(text);

class TextElement extends Element<Map<String, dynamic>, State> {
  final String text;

  TextElement(this.text) : super('', null, null, null);

  @override
  String render() => text;

  @override
  Future<String> renderAsync() => new Future.sync(() => render());
}
