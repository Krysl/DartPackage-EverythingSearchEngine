import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'cache.dart';

const site = 'www.voidtools.com';

Element getElementFromString(String? html, {String? selector}) {
  final dom = parse(html);
  final element = selector != null ? dom.querySelector(selector)! : dom.body!;
  // debug(element.outerHtml);
  return element;
}

Future<Element> getElementFromUrl(String url, {String? selector}) =>
    http.read(Uri.https(site, url)).then(
          (value) => getElementFromString(value, selector: selector),
        );

Future<Element> getWikiContentFromUrl(String url) async {
  var fileName = url.split(RegExp(r'/|\\')).last;
  if (fileName.isEmpty) fileName = 'index';

  const selector = '*.wikicontent';
  final elementCache =
      await getElementFromFileCache(fileName, selector: selector);
  final element =
      elementCache ?? await getElementFromUrl(url, selector: selector);

  await saveWikiContentCache(fileName, element);

  return element;
}
