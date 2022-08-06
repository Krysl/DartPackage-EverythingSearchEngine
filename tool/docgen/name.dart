final funcGetRegex = RegExp(r'^\s*\w+\s+get\s+(\w+)\s+');
const funcGetPrefix = 'Everything_Get';

final funcSetRegex = RegExp(r'^\s*set\s+(\w+)\s*\(((\w+) (\w+))*\)');
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
    ret = 'get ${toCamelCase(name, funcGetPrefix)}';
  } else if (name.startsWith(funcSetPrefix)) {
    ret = 'set ${toCamelCase(name, funcSetPrefix)}';
  } else if (name.startsWith(funcPrefix)) {
    ret = toCamelCase(name, funcPrefix);
  }
  return ret;
}

String? findFunName(String line) {
  String? name;
  do {
    RegExpMatch? match;

    match = funcGetRegex.firstMatch(line);
    if (match != null) {
      name = 'get ${match.group(1)!}';
      break;
    }

    match = funcSetRegex.firstMatch(line);
    if (match != null) {
      name = 'set ${match.group(1)!}';
      break;
    }
    match = funcRegex.firstMatch(line);
    if (match != null) {
      name = match.group(2);
      break;
    }
  } while (false);
  return name;
}
