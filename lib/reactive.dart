import 'dart:async';
import 'heaven.dart';

class ReactiveRenderer<P, S>
    implements Renderer<P, S, StreamController<String>, String> {
   S state;

  ReactiveRenderer(this.state) {
    _renderer = new DefaultRenderer(state);
  }

  @override
  String render(RootElementFactory<P, S> factory, StreamController<String> container) {
    // Initial rendering
    final root = factory(state);
  }

  // Todo: Async
  renderAsync(_, __) => null;
}
