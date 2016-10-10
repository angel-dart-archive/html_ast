import 'dart:async' show Future;
import 'renderer.dart';

class StringRenderer<P, S> implements Renderer<P, S, StringBuffer, String> {
  final S state;

  StringRenderer(this.state);

  @override
  String render(RootElementFactory<P, S> factory, [StringBuffer container]) {
    final StringBuffer _container = container ?? new StringBuffer();
    final root = factory(state);
    _container.write(root.render());
    return _container.toString();
  }

  @override
  Future<String> renderAsync(RootElementFactory<P, S> factory, [StringBuffer container]) async {
    final StringBuffer _container = container ?? new StringBuffer();
    final root = factory(state);
    _container.write(await root.renderAsync());
    return _container.toString();
  }
}