import 'cache.dart';
import 'name.dart';
import 'parser/doc.dart';
import 'parser/parser.dart';
import 'title_map.dart';
import 'utils.dart';

typedef DocsMap = Map<String, Doc>;

Future<DocsMap> getDocsMap() async {
  DocsMap docsMap = {};
  await loadWikiContentCache();
  final titleMap = await getTitleMap();
  final apis = getApi(titleMap);
  // debug(apis.values.toList().join('\n'));
  for (final kv in apis.entries) {
    final doc = await getDoc(kv.key, kv.value!);
    // print(doc.toString());
    var name = funNameCToDart(kv.key);

    docsMap[name] = doc;
  }
  String str = (docsMap.keys.toList()..sort()).join('\n  ');
  debug(str);
  return docsMap;
}
