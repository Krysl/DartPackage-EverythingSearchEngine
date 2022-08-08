import 'package:everything_search_engine/everything_search_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Everything everything;
  setUpAll(() {
    everything = Everything.fromDefaultLibraryPath(isLocalTest: true);
  });
  group('ffi test', () {
    test('query', () {
      final results = everything.runQuery(
        const Query(
          search: r'^pubspec\.yaml$',
          isMatchPath: false,
          isRegex: true,
          // isMatchCase: false,
          // isMatchWholeWord: false,
          requestFlags: RequestFlags(
            dateCreated: true,
          ),
          sort: EverythingSort.dateCreatedDescending,
          max: 20,
          offset: 0,
        ),
      );
      // ignore: avoid_print
      print(results.items.join('\n'));
    });
  });
}
