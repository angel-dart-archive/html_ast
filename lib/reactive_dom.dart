import 'dart:async';
import 'dart:html' as html;
import 'heaven.dart';
import 'ui.dart' as ui show TextElement;

final String _HEAVEN_ID = 'data-heaven-id';

class ReactiveDomRenderer
    extends Renderer<Map<String, dynamic>, State, html.Element, dynamic> {
  Element<Map<String, dynamic>, State> _oldRoot;
  Map<int, html.Element> _memo = {};
  Map<int, List<Element<Map<String, dynamic>, State>>> _memoChildren = {};
  html.NodeTreeSanitizer _sanitizer;
  bool renderIntoContainer;
  final Stream<State> stream;

  ReactiveDomRenderer(this.stream,
      {this.renderIntoContainer: false, bool sanitize: false})
      : super(null) {
    if (!sanitize) _sanitizer = new _TrustedHtmlTreeSanitizer();
  }

  bool canSerializeProp(prop) => prop is String || prop is num;

  html.Element renderElement(
      Element<Map<String, dynamic>, State> root, State state,
      {bool renderChildren: true, bool initialRender: false}) {
    var elem = html.window.document.createElement(root.tagName);

    if (elem == null) {
      if (root is ui.TextElement) {
        elem = new html.DivElement()..text = root.render();
      } else {
        elem = new html.Element.html(root.render(), treeSanitizer: _sanitizer);
      }
    }

    if (elem == null) {
      throw new UnsupportedError(
          'Reactive DOM renderer can only produce HTML elements.');
    }

    if (initialRender) root.id = root.hashCode;

    final rootProps = root.props;

    if (rootProps != null) {
      root.props.forEach((k, v) {
        if (k == 'class') {
          elem.className = k;
        } else if (k == 'style' && v is Map<String, dynamic>) {
          v.forEach((prop, value) {
            elem.style.setProperty(prop, value.toString());
          });
        } else if (canSerializeProp(v)) {
          elem.attributes[k] = v.toString();
        } else if (v == true) {
          elem.attributes[k] = 'true';
        }
      });
    }

    if (renderChildren) {
      final children = root.children;

      if (initialRender)
        _memoChildren[root.id] = children;

      if (children.isNotEmpty) {
        elem.children.addAll(children
            .map((child) =>
                renderElement(child, state, initialRender: initialRender))
            .where((el) => el != null));
      }
    } else if (initialRender) {
      _memoChildren[root.id] = [];
    }

    if (root.id == null) throw new Exception('$root cannot have a null ID.');

    elem.attributes[_HEAVEN_ID] = root.id.toString();

    print('Registering $root #${root.id} in MEMO');
    _memo[root.id] = elem;

    root.afterRender(elem);

    return elem;
  }

  @override
  render(RootElementFactory<Map, State> factory, html.Element container) {
    int nRenders = 0;

    this.stream.listen((state) {
      if (nRenders++ == 0) {
        final root = factory(state);
        final rendered = renderElement(root, state, initialRender: true);
        _oldRoot = root;
        _memo[_oldRoot.id] = rendered;

        container.children
          ..clear()
          ..add(rendered);
      } else {
        print("MEMO: ${_memo}");
        final newRoot = factory(state);
        runDiff(null, container, _oldRoot, newRoot, state);
      }
    });
  }

  @override
  Future renderAsync(
          RootElementFactory<Map, State> factory, html.Element container) =>
      new Future.sync(() => render(factory, container));

  void runDiff(
      Element<Map<String, dynamic>, State> parent,
      html.Element parentNode,
      Element<Map<String, dynamic>, State> prev,
      Element<Map<String, dynamic>, State> next,
      State state) {
    if (prev == null) {
      print('CREATING $next');
      parentNode.append(renderElement(next, state, initialRender: true));
    } else if (next == null) {
      print('REMOVING $prev');
      final queried =
          html.window.document.querySelector('[${_HEAVEN_ID}="${prev.id}"]');

      if (queried != null) {
        parentNode.children.remove(queried);
      }
    } else {
      if (prev.shouldUpdate(state)) {
        print("SHOULD update $prev #${prev.id} (${prev.hashCode}) with state ${state.dump()}");
        final old = _memo[next.id = prev.id];

        if (old != null) {
          print('ID of $next is now ${next.id}');
          final nextNode = renderElement(next, state);
          old.replaceWith(_memo[prev.id] = nextNode);

          if (parent != null) {
            _oldRoot = next;
          } else {
            // Todo: See if we need to replace children in vdom?
          }
        }
      }

      // Same
      final rendered = _memo[prev.id];
      print('Searched MEMO for ${prev.id}, found: $rendered');

      if (prev.id == null) {
        html.window.console.error('For some reason $prev has a null ID???');
      }

      final prevChildren = _memoChildren[prev.id];
      final nextChildren = _memoChildren[prev.id] = next.children;
      print('Prev children: $prevChildren, Next children: $nextChildren');

      for (int i = 0; i < prevChildren.length || i < nextChildren.length; i++) {
        final prevChild = i < prevChildren.length ? prevChildren[i] : null;
        final nextChild = i < nextChildren.length ? nextChildren[i] : null;

        if (prev == null || prev.shouldUpdateChild(prevChild, state)) {
          print('SHOULD update child: $prevChild');
          runDiff(prev, rendered, prevChild, nextChild, state);
        } else
          print('should NOT update child $prevChild');
      }
    }
  }
}

/**
 * A sanitizer for trees that we trust. It does no validation and allows
 * any elements.
 */
class _TrustedHtmlTreeSanitizer implements html.NodeTreeSanitizer {
  const _TrustedHtmlTreeSanitizer();

  sanitizeTree(html.Node node) {}
}
