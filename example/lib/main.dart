import 'package:everything_search_engine/everything_search_engine.dart';

Future<void> main() async {
  final everything = const Everything();

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
