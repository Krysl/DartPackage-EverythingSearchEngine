import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:change_case/change_case.dart';

const srcPath = 'lib/src/ffi/file_attribute_constants.dart';
const dstPath = 'lib/src/ffi/file_attribute.dart';

const begin = '''
import 'file_attribute_constants.dart';

class FileAttribute {
  int val;
  FileAttribute(this.val);
 
''';
const end = ''' 
}
''';

//  bool get isArchive => (val & FILE_ATTRIBUTE_ARCHIVE) != 0;
const prefix = 'FILE_ATTRIBUTE_';

Future<void> main(List<String> args) async {
  String code = await File(srcPath).readAsString();
  final strbuf = StringBuffer();

  final ast = parseString(content: code);

  strbuf.write(begin);

  for (final entity in ast.unit.childEntities) {
    if (entity is! TopLevelVariableDeclaration) continue;
    final comment = entity.documentationComment?.tokens.join();

    final variables = entity.variables.variables;
    for (final e in variables) {
      // print(e);
      final name = e.name2.toString();
      final funName = 'is${name.toPascalCase()}';
      strbuf.write('''
  $comment
  bool get $funName => (val & $name) != 0;
  ''');
    }
  }

  strbuf.write(end);

  final dstFile = File(dstPath);
  await dstFile.writeAsString(strbuf.toString());

  await Process.run('dart', ['format', 'lib/src/ffi/file_attribute.dart']);
}
