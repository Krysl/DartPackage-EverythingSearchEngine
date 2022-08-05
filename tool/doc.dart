import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

typedef LinkMap = Map<String, String?>;
typedef TitleMap = Map<String, LinkMap>;

const site = 'www.voidtools.com';

bool debugOn = true;
void debug(Object object) {
  if (debugOn) print(object);
}

Future<Element> getElementFromUrl(String url, {String? selector}) async {
  final sdk = await http.read(Uri.https(site, url));
  final dom = parse(sdk);
  final element = selector != null ? dom.querySelector(selector)! : dom.body!;
  // debug(element.outerHtml);
  return element;
}

Future<Element> getWikiContentFromUrl(String url) => getElementFromUrl(url, selector: '*.wikicontent');

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
  for (var kv in map.entries) {
    final links = kv.value;
    for (var link in links.entries) {
      if (link.key.startsWith('Everything_')) {
        linkMap[link.key] = link.value;
      }
    }
  }
  return linkMap;
}

final header = RegExp(r'^h(\d)$');

extension on int {
  bool isBetween(int min, int max) => this >= min && this <= max;
}

int? headerLevel(String tag) {
  final match = header.firstMatch(tag);
  if (match == null) return null;

  final g1 = match.group(1);
  if (g1 == null) return null;

  return int.tryParse(g1);
}

enum ParseState {
  start,
  h1,
  description,
  h2,
  syntax,
  parameters,
  returnValue,
  remarks,
  example,
  seeAlso,
  end;

  ParseState next() => ParseState.values.firstWhere(
        (e) => e.index > index,
        orElse: () => end,
      );
}

class Doc {
  String? h1;
  List<String> description = [];
  List<String> syntax = [];
  List<String> parameters = [];
  List<String> returnValue = [];
  List<String> remarks = [];
  List<String> example = [];
  List<String> functionInformation = [];
  List<String> seeAlso = [];

  @override
  String toString() => '''
/// $h1
description: ${description.join('\n')}
syntax: ${syntax.join('\n')}
parameters: ${parameters.join('\n')}
returnValue: ${returnValue.join('\n')}
remarks: ${remarks.join('\n')}
example: ${example.join('\n')}
functionInformation: ${functionInformation.join('\n')}
seeAlso: ${seeAlso.join('\n')}
'''.trimRight().split('\n').join('\n/// ');
}

ParseState parseHeader(Element e, ParseState stat, Doc doc) {
  final tag = e.localName!;
  final h = headerLevel(tag);
  if (h != null) {
    switch (h) {
      case 1:
        doc.h1 = e.text;
        stat = ParseState.description;
        break;
      case 2:
        final h2 = e.text;
        switch (h2) {
          case 'Syntax':
            stat = ParseState.syntax;
            break;
          case 'Parameters':
            stat = ParseState.parameters;
            break;
          case 'Return Value':
            stat = ParseState.returnValue;
            break;
          case 'Remarks':
            stat = ParseState.remarks;
            break;
          case 'Example':
            stat = ParseState.example;
            break;
          case 'See Also':
            stat = ParseState.seeAlso;
            break;
        }
        break;
      default:
    }
  } else {
    stat = stat.next();
  }
  return stat;
}

extension on Element {
  String get md => toMarkdown(this);
}

void _childrenMarkdown(
  Node e,
  StringBuffer strbuf, {
  String? begin,
  String? end,
}) {
  if (begin != null) strbuf.write(begin);
  for (final child in e.nodes) {
    toMarkdown(child, strbuf);
  }
  if (end != null) strbuf.write(end);
}

String toMarkdown(Node e, [StringBuffer? _strbuf]) {
  final strbuf = _strbuf ?? StringBuffer();
  if (e is Element) {
    switch (e.localName) {
      case 'p':
        _childrenMarkdown(e, strbuf);
        break;
      case 'b':
        _childrenMarkdown(e, strbuf, begin: '[', end: ']');
        break;
      case 'i':
        _childrenMarkdown(e, strbuf, begin: '**', end: '**');
        break;
      case 'br':
        strbuf.write('\n');
        break;
      case 'pre':
        _childrenMarkdown(e, strbuf, begin: '```\n', end: '\n```');
        break;
      case 'dl':
      case 'ul':
        _childrenMarkdown(e, strbuf);
        break;
      case 'dt':
      case 'li':
        _childrenMarkdown(e, strbuf, begin: '- ');
        break;
      case 'dd':
        _childrenMarkdown(e, strbuf, begin: '  ');
        break;
      case 'a':
        _childrenMarkdown(e, strbuf, begin: '[', end: '](${e.attributes['href']})');
        break;
      default:
        // throw Exception('Unsupported ${e.localName}');
        print('Unsupported ${e.localName}');
    }
  } else if (e is Text) {
    strbuf.write(e.text);
  } else {
    strbuf.write(e.toString());
  }
  return strbuf.toString();
}

ParseState parseDescription(Element e, ParseState stat, Doc doc) {
  switch (stat) {
    case ParseState.syntax:
      doc.syntax.add(e.md);
      break;
    case ParseState.parameters:
      doc.parameters.add(e.md);
      break;
    case ParseState.returnValue:
      doc.returnValue.add(e.md);
      break;
    case ParseState.remarks:
      doc.remarks.add(e.md);
      break;
    case ParseState.example:
      doc.example.add(e.md);
      break;
    case ParseState.description:
      doc.description.add(e.md //
          .replaceAll(RegExp(r'</?p>'), '')
          .replaceAll(r'<b>', '[')
          .replaceAll(r'</b>', ']'));
      break;
    case ParseState.seeAlso:
      doc.seeAlso.add(e.md);
      break;
    default:
      break;
  }

  return stat;
}

Future<Doc> getDoc(String functionName, String url) async {
  final doc = Doc();
  final wikicontent = await getWikiContentFromUrl(url);
  final children = wikicontent.children;
  ParseState stat = ParseState.start;
  for (var child in children) {
    final tag = child.localName;
    if (tag == null) continue;
    if (['br'].contains(tag)) continue;
    if (tag == 'h2') stat = ParseState.h2;

    // state machine: do after some stat
    switch (stat) {
      case ParseState.start:
      case ParseState.h1:
        stat = parseHeader(child, stat, doc);
        break;
      case ParseState.description:
        stat = parseDescription(child, stat, doc);
        break;
      case ParseState.h2:
        stat = parseHeader(child, stat, doc);
        break;
      case ParseState.syntax:
      case ParseState.parameters:
      case ParseState.returnValue:
      case ParseState.remarks:
      case ParseState.example:
      case ParseState.seeAlso:
        stat = parseDescription(child, stat, doc);
        break;
      default:
    }
  }

  return doc;
}

void main(List<String> args) async {
  final titleMap = await getTitleMap();
  // titleMap.remove('Download');
  // titleMap.remove('Download');
  final apis = getApi(titleMap);
  // debug(apis.values.toList().join('\n'));
  final first = apis.entries.first;
  final doc = await getDoc(first.key, first.value!);
  print(doc.toString());
}
