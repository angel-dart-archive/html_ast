part of heaven;

/// Serves as a single store for application-related data.
class State {
  Map<String, dynamic> data_ = {};
  StreamController onUpdate_ = new StreamController();

  Stream get onUpdate => onUpdate_.stream;

  operator [](String path) => get(path);

  operator []=(String path, value) => set(path, value);

  State();

  State.copy(State parent) {
    for (String key in parent.data_.keys) {
      data_[key] = parent.data_[key];
    }
  }

  Map resolveParent_(String path) {
    Map parent = data_;
    List<String> paths = path.split(".");

    for (int i = 0; i < paths.length - 1; i++) {
      Map target = parent[paths[i]];
      if (target == null || !(target is Map)) {
        print("Dude! This ain't a Map: $target");
        break;
      }

      parent = target;
    }

    return parent;
  }

  String lastKey_(String path) {
    return path
        .split(".")
        .last;
  }

  Map dump() => data_;

  append(String path, value) {
    List target = get(path);
    set(path, target..add(value));
  }

  forceUpdate() {
    onUpdate_.add(new StateUpdateEvent("", ""));
  }

  get(String path) {
    Map parent = resolveParent_(path);
    return parent[lastKey_(path)];
  }

  void set(String path, value) {
    Map parent = resolveParent_(path);

    if (parent != null && (parent is Map)) {
      onUpdate_.add(new StateUpdateEvent(path, value));
    } else {
      print("Invalid parent for set: $parent");
    }
  }
}

/// Triggered upon modifying the state of an application.
class StateUpdateEvent {
  final String path;
  final value;
  final bool rerender;

  const StateUpdateEvent(String this.path, this.value,
      {bool this.rerender: true});
}