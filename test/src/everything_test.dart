import 'package:everything_search_engine/everything.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Everything everything;
  setUpAll(() {
    everything = Everything.fromDefaultLibraryPath(isTest: true);
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
