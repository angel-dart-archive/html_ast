part of heaven;

class Router extends HeavenElement {
  String basePath;
  List<Route> routes = [];

  Router(String this.basePath, List<Route> this.routes) {
    if (basePath != "/") {
      Route baseRoute = new Route(basePath, null);
      //// print("Base: (${baseRoute.path}) -> ${baseRoute.matcher.pattern}");
      String head =
          baseRoute.matcher.pattern.replaceAll(new RegExp(r"\$$"), "");
      head = head.replaceAll(new RegExp(r"(\\\/)+$"), "");
      for (Route route in routes) {
        //// print("We have a route: (${route.path}) -> ${route.matcher.pattern}");
        String body =
            route.matcher.pattern.replaceAll(new RegExp(r"^\^(\\\/)+"), "");
        //// print("Head: $head, Body: $body, New: ${head + r'\/' + body}");

        // Transform child routes...
        route.matcher = new RegExp(head + r"\/" + body);
      }
    }
  }

  Route getActiveRoute([String baseLocation]) {
    String location =
        baseLocation ?? window.location.href.replaceFirst("#!", "");
    location = location
        .replaceAll(window.location.pathname, "")
        .replaceAll(window.location.host, "")
        .replaceAll(new RegExp(r"^https?:\/\/"), "")
        .replaceAll(new RegExp(r"\/+$"), "")
        .replaceAll(new RegExp(r"#.*$"), "");

    /*if (location != "/")
      location = "/" + location.replaceAll(new RegExp("^$basePath"), "");*/

    Element base = document.head.querySelector('base');
    if (base != null) {
      if (base.getAttribute('href') != null) {
        location = location.replaceAll(base.getAttribute("href"), "");
      }
    }

    if (location.isEmpty) location = "/";

    location = "/" + location.replaceAll(new RegExp(r"^\/+"), "");

    // print("Location: $location");

    for (Route route in routes) {
      // print("Test: ${route.path} -> ${route.matcher.pattern}" +
      //    "(${route.matcher.hasMatch(location).toString().toUpperCase()})");
      if (route.matcher.hasMatch(location)) {
        /*if (route.path.endsWith("*"))
          window.location.href =
              "#!$location".replaceAll(new RegExp(r"\*+$"), "");
        else
          window.location.href = "#!${route.path}";*/

        Map routeParams = route.parseParameters(location);

        // TODO: Rewrite href
        /*String uri = basePath + route.makeUri(routeParams);
        uri = uri.replaceAll(new RegExp(r'^\/+'), '');
        // print("URI: $uri");
        window.location.href = "#!/$uri";*/

        if (route.elem != null) route.elem.routeParams = routeParams;
        return route;
      } else {
        // print("${route.matcher.pattern} does not match $location ):");
      }
    }

    return null;
  }

  @override
  String render() {
    Route active = getActiveRoute();

    if (active == null)
      return "";
    else
      return active.elem.toString();
  }
}
