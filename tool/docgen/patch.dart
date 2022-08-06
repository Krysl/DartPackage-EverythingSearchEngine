import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'name.dart';
import 'parser/doc.dart';
import 'utils.dart';

final srcFilePath = p.join(parrentDir, 'lib/src/ffi/everything.dart');
final dstFilePath = p.join(parrentDir, 'lib/src/ffi/everything2.dart');
final cfgFilePath = p.join(currentDir, 'docgen.json');
final Map<String, String> functionMap = {};

Future<void> loadConfig() async {
  final cfgFile = File(cfgFilePath);
  final str = await cfgFile.readAsString();
  final json = jsonDecode(str) as Map<String, dynamic>;
  for (final kv in json.entries) {
    final v = kv.value;
    if (v is String) {
      functionMap[kv.key] = v;
    }
  }
}

Future<void> patchFile(Map<String, Doc> docsMap) async {
  final srcFile = File(srcFilePath);
  final dstFile = File(dstFilePath);
  final cfgFile = File(cfgFilePath);
  final strbuf = StringBuffer();
  final srcLines = await srcFile.readAsString().then((value) => value.split('\n'));
  int patched = 0;
  // int index = 0;
  for (final line in srcLines) {
    // if (index++ == 94) debugger();
    final name = findFunName(line);
    if (name == null) {
      strbuf.writeln(line);
      continue;
    }
    if (docsMap.containsKey(name)) {
      debug('✔$name');
      final doc = docsMap[name]!;
      patched++;
      strbuf.writeln(doc.toString());

      functionMap[doc.h1!] = name.contains(' ') //
          ? name.split(' ').last
          : name;
    } else {
      String? fixname;
      if (name.startsWith('getR')) {
        fixname = 'get r${name.substring(4)}';
      } else if (name.startsWith('setR')) {
        fixname = 'set r${name.substring(4)}';
      }
      if (docsMap.containsKey(fixname)) {
        debug('✔$fixname');
        final doc = docsMap[fixname]!;
        patched++;
        strbuf.writeln(doc.toString());
        functionMap[doc.h1!] = name;
      } else {
        debug('❌$name');
      }
    }
    strbuf.writeln(line);
  }
  await dstFile.writeAsString(strbuf.toString());
  await cfgFile.writeAsString(const JsonEncoder.withIndent('  ').convert(functionMap));
  debug('$patched function patched');
}
