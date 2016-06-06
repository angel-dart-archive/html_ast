part of heaven;

class Router extends HeavenElement {
  String basePath;
  List<Route> routes = [];

  Router(String this.basePath, List<Route> this.routes);

  Route getActiveRoute([String baseLocation]) {
    String location =
        baseLocation ?? window.location.href.replaceFirst("#!", "");
    location = location
        .replaceAll(window.location.pathname, "")
        .replaceAll(window.location.host, "")
        .replaceAll(new RegExp(r"^https?:\/\/"), "")
        .replaceAll(new RegExp(r"\/+$"), "")
        .replaceAll(new RegExp(r"#.*$"), "");

    Element base = document.head.querySelector('base');
    if (base != null) {
      if (base.getAttribute('href') != null) {
        location = location.replaceAll(base.getAttribute("href"), "");
      }
    }

    if (location.isEmpty) location = "/";

    //print("Location: $location");

    for (Route route in routes) {
      if (route.matcher.hasMatch(location)) {
        if (route.path == "*")
          window.location.href = "#!$location";
        else
          window.location.href = "#!${route.path}";
        return route;
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
