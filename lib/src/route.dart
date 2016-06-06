part of heaven;

class Route {
  RegExp matcher;
  HeavenElement elem;
  String path;
  String name;

  Route(Pattern path, HeavenElement this.elem) {
    if (path is RegExp) {
      this.matcher = path;
      this.path = path.pattern;
    } else {
      this.matcher = new RegExp('^' +
          path
              .toString()
              .replaceAll(new RegExp(r'\/\*$'), "*")
              .replaceAll(new RegExp('\/'), r'\/')
              .replaceAll(new RegExp(':[a-zA-Z_]+'), '([^\/]+)')
              .replaceAll(new RegExp('\\*'), '.*') +
          r'$');
      this.path = path;
    }
  }

  /// Assigns a name to this Route.
  as(String name) {
    this.name = name;
    return this;
  }

  String makeUri([Map<String, dynamic> params]) {
    String result = path;
    if (params != null) {
      for (String key in (params.keys)) {
        result = result.replaceAll(new RegExp(":$key"), params[key].toString());
      }
    }

    return result;
  }

  parseParameters(String requestPath) {
    Map result = {};

    Iterable<String> values = _parseParameters(requestPath);
    RegExp rgx = new RegExp(':([a-zA-Z_]+)');
    Iterable<Match> matches =
        rgx.allMatches(path.replaceAll(new RegExp('\/'), r'\/'));
    for (int i = 0; i < matches.length; i++) {
      Match match = matches.elementAt(i);
      String paramName = match.group(1);
      String value = values.elementAt(i);
      num numValue = num.parse(value, (_) => double.NAN);
      if (!numValue.isNaN)
        result[paramName] = numValue;
      else
        result[paramName] = value;
    }

    return result;
  }

  _parseParameters(String requestPath) sync* {
    Match routeMatch = matcher.firstMatch(requestPath);
    for (int i = 1; i <= routeMatch.groupCount; i++) yield routeMatch.group(i);
  }
}
