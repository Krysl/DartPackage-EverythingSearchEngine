import 'package:meta/meta.dart';

import '../ffi/everything.dart';
import '../ffi/everything.g.dart';
import '../ffi/request_flags.dart';
import '../ffi/sort.dart';

/// config to execute query
@immutable
class Query {
  /// [Everything.search]
  final String search;

  /// [Everything.matchPath]
  final bool isMatchPath;

  /// [Everything.matchCase]
  final bool isMatchCase;

  /// [Everything.matchWholeWord]
  final bool isMatchWholeWord;

  /// [Everything.regex]
  final bool isRegex;

  /// [Everything.max]
  final int? max;

  /// [Everything.offset]
  final int? offset;

  /// [Everything.replyWindow]
  final HWND? replyWindow;

  /// [Everything.replyID]
  final int? replyID;

  /// [Everything.sort]
  final EverythingSort sort;

  /// [Everything.requestFlags]
  final RequestFlags requestFlags;

  /// create a config to execute query
  const Query({
    required this.search,
    this.isMatchPath = false,
    this.isMatchCase = false,
    this.isMatchWholeWord = false,
    this.isRegex = false,
    this.max,
    this.offset,
    this.replyWindow,
    this.replyID,
    this.sort = EverythingSort.nameAscending,
    this.requestFlags = const RequestFlags(),
  });

  @override
  int get hashCode => Object.hash(
        search,
        isMatchPath,
        isMatchCase,
        isMatchWholeWord,
        isRegex,
        max,
        offset,
        replyWindow,
        replyID,
        sort,
        requestFlags,
      );

  @override
  bool operator ==(Object other) {
    if (other is! Query) return false;
    return hashCode == other.hashCode;
  }
}
