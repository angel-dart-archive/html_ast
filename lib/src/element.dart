part of heaven;

/// Represents a dynamic element that can be re-rendered based
/// on the application state.
class HeavenElement {
  int ID;
  Map<String, dynamic> props = {};
  State state;
  HeavenElement([Map<String, dynamic> this.props]);
  void afterRender(Element elem) {}
  String render() => "";

  @override
  String toString() {
    return Heaven.globalInstance.renderElem(this).innerHtml;
  }
}
