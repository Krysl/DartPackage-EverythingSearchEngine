import 'package:html/dom.dart';

import '../crawler.dart';
import '../patch.dart';
import '../utils.dart';
import 'doc.dart';
import 'state.dart';

final header = RegExp(r'^h(\d)$');

int? headerLevel(String tag) {
  final match = header.firstMatch(tag);
  if (match == null) return null;

  final g1 = match.group(1);
  if (g1 == null) return null;

  return int.tryParse(g1);
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

bool isInLink = false;
bool isInParagraph = false;
bool isInBold = false;
bool isInTable = false;
bool ignoreHref = false;
bool ignoreText = false;
int col = 0;
String toMarkdown(Node e, [StringBuffer? strbuf]) {
  strbuf ??= StringBuffer();
  if (e is Element) {
    switch (e.localName) {
      case 'p':
        isInParagraph = true;
        _childrenMarkdown(e, strbuf);
        isInParagraph = false;
        break;
      case 'b':
        isInBold = true;
        _childrenMarkdown(e, strbuf, begin: '**', end: '**');
        isInBold = false;
        break;
      case 'i':
        _childrenMarkdown(e, strbuf, begin: '*', end: '*');
        break;
      case 'br':
        if (isInTable) break;
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
        isInLink = true;
        _childrenMarkdown(e, strbuf, begin: '[', end: ']');
        if (ignoreHref == false) strbuf.write('(${e.attributes['href']})');
        ignoreHref = false;
        isInLink = false;
        break;
      case 'table':
        ignoreText = true;
        isInTable = true;
        _childrenMarkdown(e, strbuf, end: '\n');
        isInTable = false;
        ignoreText = false;
        break;
      case 'tbody':
        _childrenMarkdown(e, strbuf);
        break;
      case 'tr':
        col = 0;
        _childrenMarkdown(e, strbuf, begin: '\n| ');
        if (col > 0) {
          strbuf.write('\n|${' --- |' * col}');
          col = 0;
        }
        break;
      case 'th':
        ignoreText = false;
        _childrenMarkdown(e, strbuf, begin: ' ', end: ' |');
        ignoreText = true;
        col++;
        break;
      case 'td':
        ignoreText = false;
        _childrenMarkdown(e, strbuf, begin: ' ', end: ' |');
        ignoreText = true;
        break;
      default:
        // throw Exception('Unsupported ${e.localName}');
        error('Unsupported ${e.localName}');
    }
  } else if (e is Text) {
    if (ignoreText) return strbuf.toString();
    if (isInLink && functionMap.containsKey(e.text)) {
      ignoreHref = true;
      strbuf.write(functionMap[e.text]!.toName());
    } else if (isInParagraph) {
      if (functionMap.containsKey(e.text)) {
        strbuf.write('[${functionMap[e.text]!.toName()}]');
      } else {
        strbuf.write(
          e.text //
              .replaceAll(r'[', r'\[')
              .replaceAll(r']', r'\]'),
        );
      }
    } else if (isInBold && functionMap.containsKey(e.text)) {
      strbuf.write('[${functionMap[e.text]!.toName()}]');
    } else {
      strbuf.write(e.text);
    }
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
  for (final child in children) {
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
