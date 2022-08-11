import 'dart:developer';

import 'patch.dart';
import 'utils.dart';

final funcGetRegex = RegExp(r'^\s*(\w+)\s+get\s+(\w+)\s+');
const funcGetPrefix = 'Everything_Get';

final funcSetRegex =
    RegExp(r'^ *set +(?<fun>\w+)\s*\(((?<type>\w+) (?<arg>\w+),?\s*)*\)');
const funcSetPrefix = 'Everything_Set';

final funcRegex = RegExp(
    r'^ *((?!set)\w+)\s+(\w+)\s*\((\n?)(\s*(\w+)\s+(\w+),?)*\s*(\n?\{(\n?\s*(\w+)\s+(\w+)\s*(=\s*\w+)?,?)*\n?\})?\s*\)');
const funcPrefix = 'Everything_';

String toCamelCase(String str, String remove) =>
    str[remove.length].toLowerCase() +
    str.substring(remove.length + 1).replaceAllMapped(
          RegExp(r'_(\w)'),
          (m) => m[1]?.toUpperCase() ?? '',
        );

String funNameCToDart(String name) {
  String ret = name;
  if (name.startsWith(funcGetPrefix)) {
    final funcName = toCamelCase(name, funcGetPrefix);
    ret = 'get $funcName';
    if (!functionMap.containsKey(ret) && funcName.startsWith('r')) {
      final tmp = 'get${funcName.upperFirst()}';
      if (functionMap.containsKey(tmp)) {
        ret = tmp;
      }
    }
  } else if (name.startsWith(funcSetPrefix)) {
    final funcName = toCamelCase(name, funcSetPrefix);
    ret = 'set $funcName';
    if (!functionMap.containsKey(ret) && funcName.startsWith('r')) {
      final tmp = 'set${funcName.upperFirst()}';
      if (functionMap.containsKey(tmp)) {
        ret = tmp;
      }
    }
  } else if (name.startsWith(funcPrefix)) {
    ret = toCamelCase(name, funcPrefix);
  }

  return ret;
}

enum FunctionType { set, get, normal }

enum FunctionParameterType { set, get, normal }

class FunctionParameter {
  bool required;
  bool positional;
  bool named;
  String type;
  String name;
  FunctionParameter({
    required this.required,
    required this.positional,
    required this.named,
    required this.type,
    required this.name,
  });
}

class FunctionInfo {
  FunctionType type;
  String name;
  String? ret;
  List<FunctionParameter> parameters;
  FunctionInfo({
    required this.type,
    required this.name,
    this.ret,
    this.parameters = const [],
  });
  FunctionInfo.get({
    required String name,
    String? ret,
    List<FunctionParameter> parameters = const [],
  }) : this(
          type: FunctionType.get,
          name: name,
          ret: ret,
          parameters: parameters,
        );
  FunctionInfo.set({
    required String name,
    String? ret,
    List<FunctionParameter> parameters = const [],
  }) : this(
          type: FunctionType.get,
          name: name,
          ret: ret,
          parameters: parameters,
        );
  FunctionInfo.normal({
    required String name,
    String? ret,
    List<FunctionParameter> parameters = const [],
  }) : this(
          type: FunctionType.normal,
          name: name,
          ret: ret,
          parameters: parameters,
        );
}

FunctionInfo? findFunName(String line) {
  String? name;
  String? ret;
  FunctionInfo? info;
  // List<FunctionParameter> paras = [];
  do {
    RegExpMatch? match;

    match = funcGetRegex.firstMatch(line);
    if (match != null) {
      ret = match[1];
      name = match.group(2)!;
      info = FunctionInfo.get(
        name: name,
        ret: ret,
      );
      break;
    }

    match = funcSetRegex.firstMatch(line);
    if (match != null) {
      name = match.group(1)!;
      if (match.groupCount > 3) {
        debugger();
      }
      // match.grou
      info = FunctionInfo.get(
        name: name,
        ret: ret,
      );
      break;
    }
    match = funcRegex.firstMatch(line);
    if (match != null) {
      name = match.group(2);
      break;
    }
  } while (false);
  return info;
}
