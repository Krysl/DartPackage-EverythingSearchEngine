import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;

import 'parser/doc.dart';
import 'utils.dart';

final srcFilePath = p.join(parrentDir, 'lib/src/ffi/everything.dart');
final dstFilePath = p.join(parrentDir, 'lib/src/ffi/everything_api.g.dart');

final LinkedHashMap<String, MethodDeclaration> functionMap = LinkedHashMap<String, MethodDeclaration>();

Future<void> loadFunctionMap() async {
  final srcFile = File(srcFilePath);
  final src = await srcFile.readAsString();
  final ast = parseString(content: src);
  for (final child in ast.unit.childEntities) {
    if (child is ClassDeclaration) {
      if (child.name2.toString() != 'Everything') continue;
      final members = child.members;
      for (final member in members) {
        if (member is MethodDeclaration) {
          final name = member.name2.toString();
          var docName = name;
          if (member.isGetter) docName = 'get $docName';
          if (member.isSetter) docName = 'set $docName';
          functionMap[docName] = member;
        }
      }
    }
  }
}

extension MethodDeclarationHelper on MethodDeclaration {
  String toName() => name2.toString();
  String toDocName() {
    var docName = name2.toString();
    if (isGetter) docName = 'get $docName';
    if (isSetter) docName = 'set $docName';
    return docName;
  }
}

const head = '''
// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'everything.g.dart';
import 'request_flags.dart';
import 'sort.dart';
import 'target_machine.dart';

/// Automatically generated interface for doc functions in sdk api.
/// [Everything] implements [EverythingApi], so function in [Everything] with same name will also be documented.
/// ```bat
/// dart tool/docgen.dart 
/// ```
abstract class EverythingApi {
''';
const end = '}';

const excludeFunction = ['runQuery', '_getFileTime'];
Future<void> patchFile(Map<String, Doc> docsMap) async {
  final dstFile = File(dstFilePath);
  final strbuf = StringBuffer();
  int patched = 0;

  strbuf.write(head);

  for (final child in functionMap.values) {
    final member = child;
    final name = member.name2.toString();
    if (excludeFunction.contains(name)) continue;

    final doc = getDoc(docsMap, member);
    if (doc != null) strbuf.writeln(doc);

    strbuf.write('  ');
    if (member.externalKeyword != null) strbuf.write('external ');

    if (member.isAbstract) strbuf.write('abstract ');
    if (member.isStatic) strbuf.write('static ');

    if (member.returnType != null) strbuf.write('${member.returnType} ');

    if (member.isGetter) strbuf.write('get ');
    if (member.isSetter) strbuf.write('set ');

    strbuf.write(name);

    if (member.typeParameters != null) strbuf.write(member.typeParameters.toString());
    if (member.parameters != null) strbuf.write(member.parameters.toString());
    strbuf.write(';\n\n');
    patched++;
  }
  strbuf.write(end);
  await dstFile.writeAsString(strbuf.toString().split('\n').map((e) => e.trimRight()).join('\n'));

  debug('$patched function patched');
}

String? getDoc(Map<String, Doc> docsMap, MethodDeclaration method) {
  String? ret;
  final docName = method.toDocName();
  if (docsMap.containsKey(docName)) {
    debug('✔$docName');
    final doc = docsMap[docName]!;

    ret = doc.toString();
  } else {
    debug('❌$docName');
  }
  return ret;
}
