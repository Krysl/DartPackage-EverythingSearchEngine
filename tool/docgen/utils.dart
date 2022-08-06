// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path/path.dart' as p;

bool debugOn = true;
void debug(Object? object) {
  if (debugOn) print(object);
}

void error(Object object) => print(object);

final currentDir = p.dirname(Platform.script.toFilePath(windows: true));
final parrentDir = p.normalize(p.join(currentDir, '..'));
