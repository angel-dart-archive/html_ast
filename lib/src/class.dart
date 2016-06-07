part of heaven;

class Heaven {
  static Heaven globalInstance;
  HeavenElement root;
  Router router;
  Element rootNode;
  State state = new State();
  bool pushState;
  bool handledHash_ = false;

  RegExp rgxArr = new RegExp(r"^arr:");

  int nRendered = 0;

  Heaven(HeavenElement this.root, Element this.rootNode,
      {bool this.pushState: true}) {
    Heaven.globalInstance = this;
    state.onUpdate.listen(onStateChanged);

    if (this.root is Router)
      this.router = root;
    else if (this.root is RoutedHeavenElement) {
      RoutedHeavenElement routed = root;
      router = routed.router;
    }

    window.onHashChange.listen((_) {
      if (this.router != null) {
        if (!handledHash_) {
          handledHash_ = true;
          renderDom();
        } else
          handledHash_ = false;
      }
    });
  }

  onStateChanged(StateUpdateEvent event) {
    print("State changed!");
    print("Time travel:");
    print("We set ${event.path} to ${event.value}");
    print("Old: ${event.priorState.data_}");
    print("New: ${event.newState.data_}");
    state = event.newState;
    renderDom();
  }

  void renderDom() {
    nRendered = 0;

    rootNode.children
      ..clear()
      ..add(renderElem(root));
  }

  Element renderElem(HeavenElement elem) {
    for (String toRequire in elem.requires) {
      String require = "";
      if (rgxArr.hasMatch(toRequire))
        require = toRequire.replaceAll(rgxArr, "");
      else
        require = toRequire;
      if (state[require] == null) {
        state.data_[require] = rgxArr.hasMatch(toRequire) ? [] : {};
      }
    }

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
