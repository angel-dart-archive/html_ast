import 'package:heaven/heaven.dart';
import 'package:heaven/ui.dart';

_ColorsApp ColorsApp(State state) => new _ColorsApp(state);

class _ColorsApp extends DivElement {
  _ColorsApp(State state) : super(state, {});

  @override
  List<Element<Map<String, dynamic>, State>> get children {
    return [
      h1(state, {'style': 'color: ${state.color};'}, [text('Colors')]),
      new Element<Map<String, dynamic>, State>(
          'button', state, {'type': 'button'}, [text('YEET')])
    ];
  }
}
