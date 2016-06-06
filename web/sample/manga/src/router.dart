part of manga;

class AppRouter extends HeavenElement {
  Router router = new Router("/", [new Route("*", new MangaList())]);

  AppRouter() {
    window.onHashChange.listen((_) {
      if (state != null) {
        state.forceUpdate();
      }
    });
  }

  @override
  String render() => router.render();
}
