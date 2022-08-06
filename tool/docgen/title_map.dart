import 'crawler.dart';
import 'utils.dart';

typedef LinkMap = Map<String, String?>;
typedef TitleMap = Map<String, LinkMap>;

Future<TitleMap> getTitleMap() async {
  final TitleMap titleMap = {};

  final wikicontent = await getWikiContentFromUrl('support/everything/sdk/');
  final titleList = wikicontent.querySelectorAll('h2');
  for (final title in titleList) {
    debug('## ${title.text}');
    final LinkMap linkMap = {};
    titleMap[title.text] = linkMap;
    var next = title.nextElementSibling;
    if (next == null) continue;
    while (next?.localName != 'ul') {
      next = next?.nextElementSibling;
      if (next == null) break;
      if (next.localName == 'h2') break;
    }
    final ul = next!;
    final links = ul.querySelectorAll('a');
    for (final link in links) {
      linkMap[link.text] = link.attributes['href'];
    }
  }
  // debug(titleMap);
  return titleMap;
}

LinkMap getApi(TitleMap map) {
  final LinkMap linkMap = {};
  for (final kv in map.entries) {
    final links = kv.value;
    for (final link in links.entries) {
      if (link.key.startsWith('Everything_')) {
        linkMap[link.key] = link.value;
      }
    }
  }
  return linkMap;
}
