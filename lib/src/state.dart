part of heaven;

/// Serves as a single store for application-related data.
class State {
  Map<String, dynamic> data_ = {};
  StreamController onUpdate_ = new StreamController();
  Stream get onUpdate => onUpdate_.stream;

  operator [](String path) => get(path);
  operator []=(String path, value) => set(path, value);

  Map resolveParent_(String path) {
    print("Resolving $path");
    Map parent = data_;
    List<String> paths = path.split(".");

    for (int i = 0; i < paths.length - 1; i++) {
      Map target = parent[paths[i]];
      print("Searching for ${paths[i]}");
      print("Found: $target");

      if (target == null || !(target is Map)) {
        print("Dude! This ain't a Map: $target");
        break;
      }

      parent = target;
    }

    return parent;
  }

  String lastKey_(String path) {
    return path.split(".").last;
  }

  Map dump() => data_;

  append(String path, value) {
    List target = get(path);
    set(path, target..add(value));
  }

  forceUpdate() {
    onUpdate_.add(new StateUpdateEvent("", "", data_));
  }

  get(String path) {
    Map parent = resolveParent_(path);
    print("get: $path");
    return parent[lastKey_(path)];
  }

  void set(String path, value) {
    print("set: $path, $value");
    Map parent = resolveParent_(path);

    if (parent != null && (parent is Map)) {
      print("Let's set $path to $value, yeah!");
      onUpdate_.add(new StateUpdateEvent(path, value, data_));
      parent[lastKey_(path)] = value;
    } else {
      print("Invalid parent for set: $parent");
    }
  }
}

/// Triggered upon modifying the state of an application.
class StateUpdateEvent {
  final Map<String, dynamic> priorState;
  final String path;
  final value;

  const StateUpdateEvent(
      String this.path, this.value, Map<String, dynamic> this.priorState);
}
