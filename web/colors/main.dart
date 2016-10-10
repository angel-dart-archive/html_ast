import 'dart:async';
import 'dart:html';
import 'package:heaven/dom.dart';
import 'package:heaven/heaven.dart';
import 'components/app.dart';

main() {
  final container = window.document.getElementById('app');
  final controller = new StreamController<State>();
  final FormElement form = window.document.querySelector('form');
  final InputElement input = window.document.querySelector('#color');

  form.onSubmit.listen((e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    e.stopPropagation();

    final color = input.value;

    if (color.isEmpty) {
      window.alert('Invalid color provided!');
    } else {
      controller.add(new State.fromMap({'color': color.toLowerCase()}));
    }
  });

  controller.stream.listen((state) {
    new DomRenderer(state).render(ColorsApp, container);
  });

  // Initial state
  controller.add(new State.fromMap({'color': 'pink'}));
}
