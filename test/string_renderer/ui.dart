import 'package:heaven/heaven.dart';
import 'package:heaven/ui.dart' as ui;
import 'package:test/test.dart';

main() {
  final state = new State();
  final renderer = new DefaultRenderer(state);

  group('div', () {
    test('simple div', () {
      final view = renderer.render(ui.div);
      print(view);
      expect(view, equals('<div></div>'));
    });

    test('div with text', () {
      final view = renderer
          .render((state) => ui.div(state, {}, [ui.text('Hello, world!')]));
      print(view);
      expect(view, equals('<div>Hello, world!</div>'));
    });
  });
}
