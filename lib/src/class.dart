part of heaven;

class Heaven {
  static Heaven globalInstance;
  HeavenElement root;
  Element rootNode;
  State state = new State();

  int nRendered = 0;

  Heaven(HeavenElement this.root, Element this.rootNode) {
    Heaven.globalInstance = this;
    state.onUpdate.listen(onStateChanged);
  }

  onStateChanged(StateUpdateEvent event) {
    print("State changed!");
    print("Time travel: ${event.priorState}");
    print("We set ${event.path} to ${event.value}");
    renderDom();
  }

  void renderDom() {
    nRendered = 0;

    rootNode.children
      ..clear()
      ..add(renderElem(root));
  }

  Element renderElem(HeavenElement elem) {
    elem
      ..ID = nRendered
      ..state = state;
    Element result = window.document.createElement('div');
    result.innerHtml = elem.render();
    result.setAttribute(STRINGS.ID, elem.ID.toString());
    elem.afterRender(result);
    nRendered++;
    return result;
  }
}
