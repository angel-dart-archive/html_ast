import 'dart:async' show Future;

abstract class Renderable<T> {
  T render();
  Future<T> renderAsync();
}