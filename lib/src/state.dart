final RegExp _symbol = new RegExp(r'Symbol\("([^"]+)"\)');

abstract class AbstractState<K, V> {
  Map<K, V> _data;

  V operator [](K key) => get(key);

  Map<K, V> dump();

  V get(K key);
}

@proxy
class State extends AbstractState<String, dynamic> {
  final Map<String, dynamic> _data;

  State() : _data = new Map<String, dynamic>.unmodifiable({});

  State.fromMap(Map<String, Map> data)
      : _data = new Map<String, dynamic>.unmodifiable(data);

  get(String key) => _data[key];

  Map<String, dynamic> dump() => _data;

  @override
  noSuchMethod(Invocation invocation) {
    if (invocation.isGetter || invocation.isAccessor) {
      final match = _symbol.firstMatch(invocation.memberName.toString());

      if (match != null) return get(match.group(1));
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
