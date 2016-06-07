part of manga;

class MangaList extends HeavenElement {
  @override
  List<String> requires = ['manga_list', 'arr:manga'];
  List<MangaCard> manga = [];
  bool loading = true;
  int page = 0;
  int limit = 25;

  fetchMangas() async {
    loading = true;
    state['manga_list.loading'] = loading;
    String json = await HttpRequest
        .getString("https://www.mangaeden.com/api/list/0?p=$page&l=$limit");
    loading = false;
    state['manga_list.loading'] = loading;
    Map mangas = JSON.decode(json);
    if (mangas != null) {
      state['manga'] = mangas['manga'];
      print(mangas['manga']);
      this.manga = mangas['manga'].map((m) => new MangaCard(m));
    } else
      window.console.error(json);
  }

  @override
  void afterRender(Element elem) {
    state['manga_list.loading'] = loading;
    fetchMangas();
  }

  @override
  String render() {
    if (false && state['manga_list.loading']) {
      return '''
      <i>Loading...</i>
      ''';
    }

    return '''
    <div class="ui dividing header">
      <i class="book icon"></i>
      Manga (${state['manga'].length})
    </div>
    <div class="ui four cards">
      ${manga.map((m) => '<b>${m.manga['t']}</b>').join()}
      ${state['manga'].map((x) => new MangaCard(x)).join()}
    </div>
    ''';
  }
}

class MangaCard extends HeavenElement {
  Map<String, dynamic> manga;
  final String basePath = "https://cdn.mangaeden.com/mangasimg/";

  MangaCard(Map<String, dynamic> this.manga);

  @override
  String render() => '''
  <div class="ui card">
    <div class="image">
      <img src="$basePath/${manga['im']}" />
    </div>
    <div class="content">
      <a class="header" href="#!/manga/${manga['i']}">
        ${manga['t']}
      </a>
      <div class="meta">
        <span class="date">${manga['s']}</span>
      </div>
      <div class="description">
        ${manga['c']}
      </div>
  </div>
  ''';
}
