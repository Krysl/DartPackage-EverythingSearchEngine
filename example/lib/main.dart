import 'package:everything_search_engine/everything_search_engine.dart';

Future<void> main() async {
  /// `await Everything.ensureInited()` must be called before `Everything.fromDefaultLibraryPath()` unless you use your own dll library
  await Everything.ensureInited();

  late Everything everything = Everything.fromDefaultLibraryPath();

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
}
