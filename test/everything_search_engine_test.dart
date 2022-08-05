import 'package:everything_search_engine/everything_search_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Everything everything;
  setUpAll(() {
    everything = Everything.fromDefaultLibraryPath(isLocalTest: true);
  });
  group('ffi test', () {
    test('query', () {
      everything.runQuery(
        '^pubspec\\.yaml\$',
        isMatchPath: false,
        isRegex: true,
      );
    });
    test('query', () {
      everything.runQuery(
        'public run',
        isMatchPath: true,
        isRegex: false,
      );
    });
  });
}
