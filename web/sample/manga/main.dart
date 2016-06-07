library manga;

import 'dart:convert';
import 'dart:html';
import 'package:heaven/heaven.dart';

part 'src/manga_list.dart';
part 'src/router.dart';

main() {
  Heaven heaven = new Heaven(new AppRouter(), document.getElementById('app'));
  heaven.renderDom();
}
