part of heaven;

class Conditional extends HeavenElement {
  bool condition;
  String source;

  Conditional(bool this.condition);

  void ok(String source) {
    this.source = source;
  }

  @override
  String render() {
    return condition ? source : "";
  }
}
