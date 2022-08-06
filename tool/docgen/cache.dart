import 'dart:io';

import 'package:html/dom.dart';
import 'package:path/path.dart' as p;

import 'crawler.dart';
import 'utils.dart';

/// Map url->path
Map<String, String> wikiContent = {};
final cacheDir = Directory(
  p.join(currentDir, 'cache'),
);

Future<void> loadWikiContentCache() => cacheDir.list().listen((entity) {
      final path = entity.path;
      final name = p.basenameWithoutExtension(path);
      wikiContent[name] = entity.path;
    }).asFuture();

Future<Element> getElementFromFile(String file, {String? selector}) => File(file).readAsString().then(
      (value) => getElementFromString(value, selector: selector),
    );
Future<Element>? getElementFromFileCache(String fileName, {String? selector}) {
  final cacheFilePath = wikiContent[fileName];
  if (cacheFilePath != null) {
    return getElementFromFile(cacheFilePath, selector: '*.wikicontent');
  } else {
    return null;
  }
}

Future<void> saveWikiContentCache(String fileName, Element element) async {
  final writefile = File(
    p.setExtension(
      p.join(cacheDir.path, fileName),
      '.html',
    ),
  );
  await writefile.writeAsString(element.outerHtml);
}
