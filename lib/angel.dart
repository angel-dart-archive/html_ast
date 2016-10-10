import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import 'package:heaven/heaven.dart';

class Heaven extends AngelPlugin {
  final Map<String,
      RootElementFactory<Map<String, dynamic>, State>> factories = {};

  Heaven({Map<String,
      RootElementFactory<Map<String, dynamic>, State>> factories: const {}}) {
    this.factories.addAll(factories);
  }

  @override
  Future call(Angel app) async {
    app.viewGenerator = (path, [Map params]) {
      final factory = factories[path];
      final state = new State.fromMap(params ?? {});
      return new DefaultRenderer(state).renderAsync(factory);
    };
  }
}