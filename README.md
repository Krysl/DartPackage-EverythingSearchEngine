![](assets/icon/Everything.ico)

A package that wraps [![](assets/icon/Everything-rgb888-16x16.jpg) Everything SDK](https://www.voidtools.com/en-us/support/everything/sdk/) API calls using [FFI](https://dart.dev/guides/libraries/c-interop) to make them accessible to Dart code.

- "[![](assets/icon/Everything-rgb888-16x16.jpg) Everything](https://www.voidtools.com/en-us/)" is a filename search engine for Windows.
- [![](assets/icon/Everything-rgb888-16x16.jpg) Everything SDK](https://www.voidtools.com/en-us/support/everything/sdk/) provides a DLL and Lib interface to Everything over IPC.
## Features


## Getting started

`dart pub add everything_search_engine`

```dart
import 'package:everything_search_engine/everything.dart';

Everything everything = Everything.fromDefaultLibraryPath();
```

## Usage


```dart
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

```

## Additional information

- [![](assets/icon/Everything-rgb888-16x16.jpg) SDK API document](https://www.voidtools.com/support/everything/sdk/)
- [![](assets/icon/Everything-rgb888-16x16.jpg) Query Language document](https://www.voidtools.com/support/everything/searching/)
