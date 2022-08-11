import 'package:everything_search_engine/everything_search_engine.dart';
import 'package:test/test.dart';

void main() async {
  late Everything everything;
  setUpAll(() async {
    await Everything.ensureInited();
    everything = Everything.fromDefaultLibraryPath();
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
