import 'dart:async' show Future;
import 'element.dart' show Element;

typedef Element<P, S> RootElementFactory<P, S>(S state);

abstract class Renderer<P, S, C, O> {
  final S state;

  Renderer(this.state);
  O render(RootElementFactory<P, S> factory, C container);
  Future<O> renderAsync(RootElementFactory<P, S> factory, C container);
}