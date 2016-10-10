import 'dart:async' show Future;
import 'dart:html' as html show Element, Node, NodeTreeSanitizer;
import 'heaven.dart';

class DomRenderer
    extends Renderer<Map<String, dynamic>, State, html.Element, html.Element> {
  DefaultRenderer _renderer;
  html.NodeTreeSanitizer _sanitizer;
  bool sanitize;

  DomRenderer(State state, {this.sanitize : false}) : super(state) {
    _renderer = new DefaultRenderer(state);

    if (!sanitize)
      _sanitizer = new _TrustedHtmlTreeSanitizer();
  }

  @override
  html.Element render(
      RootElementFactory<Map, State> factory, html.Element container) {
    return container..setInnerHtml(_renderer.render(factory), treeSanitizer: _sanitizer);
  }

  @override
  Future<html.Element> renderAsync(
          RootElementFactory<Map, State> factory, html.Element container) =>
      new Future.sync(() => render(factory, container));
}

/**
 * A sanitizer for trees that we trust. It does no validation and allows
 * any elements.
 */
class _TrustedHtmlTreeSanitizer implements html.NodeTreeSanitizer {
  const _TrustedHtmlTreeSanitizer();

  sanitizeTree(html.Node node) {}
}
