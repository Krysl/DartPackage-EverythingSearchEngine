// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

import '../assets.dart';
import '../query/query.dart';
import '../query/results.dart';
import 'everything.g.dart';
import 'everything_api.g.dart';
import 'file_attribute.dart';
import 'request_flags.dart';
import 'sort.dart';
import 'string.dart';
import 'target_machine.dart';

extension on bool {
  int get toInt => this ? 1 : 0;
}
/// microseconds From 1601-1-1 To 1970-1-1
final microsecondsFrom1601To1970 =
    DateTime.fromMicrosecondsSinceEpoch(0).difference(DateTime.utc(1601, 1, 1)).inMicroseconds;

/// helper for FILETIME
extension FileTImeHelper on FILETIME {
  /// Contains a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (UTC).
  int get hundredNanoseconds => (dwHighDateTime << 32) + dwLowDateTime;

  /// nanosecond intervals since January 1, 1601 (UTC).
  int get nanosecond => hundredNanoseconds * 100;

  /// trans to DateTime(UTC)
  DateTime get utc => DateTime.fromMicrosecondsSinceEpoch(hundredNanoseconds ~/ 10 - microsecondsFrom1601To1970);
}

/// A class that wrap everything sdk's api
class Everything implements EverythingApi {
  final EverythingBase _;

  /// The symbols are looked up in [dynamicLibrary].
  Everything(ffi.DynamicLibrary dynamicLibrary) : _ = EverythingBase(dynamicLibrary);

  /// init using built-in library's path
  factory Everything.fromLibraryPath(String libraryPath) {
    assert(File(libraryPath).existsSync(), 'file $libraryPath not exist in ${Directory.current}');
    return Everything(ffi.DynamicLibrary.open(libraryPath));
  }

  /// init using internal library's path
  factory Everything.fromDefaultLibraryPath({
    /// use only in development of this package
    bool isLocalTest = false,

    /// use in test for common user
    bool isTest = false,
  }) =>
      Everything.fromLibraryPath(
        path.normalize(
          path.join(
            isLocalTest //
                ? ''
                : (isTest ? 'build/flutter_assets' : 'data/flutter_assets'),
            isLocalTest //
                ? Assets.Everything64_dll
                : Assets.everything_search_engine$Everything64_dll,
          ),
        ),
      );

  /// The symbols are looked up with [lookup].
  Everything.fromLookup(ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) lookup)
      : _ = EverythingBase.fromLookup(lookup);

/* codegen begin */
  /* API */
  /* version */
  @override
  int get majorVersion => _.GetMajorVersion();
  @override
  int get minorVersion => _.GetMinorVersion();
  @override
  int get revision => _.GetRevision();
  @override
  int get buildNumber => _.GetBuildNumber();
  @override
  EverythingTargetMachine get targetMachine => EverythingTargetMachine.fromVal(_.GetTargetMachine());
  /* search */
  /// write search state
  @override
  set search(String lpString) => _.SetSearchW(lpString.toLPCWSTR());
  @override
  String get search => _.GetSearchW().toDartString();

  @override
  int get lastError => _.GetLastError();

  /* search mode */
  @override
  set matchCase(bool bEnable) => _.SetMatchCase(bEnable.toInt);
  @override
  bool get matchCase => _.GetMatchCase() == 1;

  @override
  set matchWholeWord(bool bEnable) => _.SetMatchWholeWord(bEnable.toInt);
  @override
  bool get matchWholeWord => _.GetMatchWholeWord() == 1;

  @override
  set matchPath(bool bEnable) => _.SetMatchPath(bEnable.toInt);
  @override
  bool get matchPath => _.GetMatchPath() == 1;

  @override
  set regex(bool bEnable) => _.SetRegex(bEnable.toInt);
  @override
  bool get regex => _.GetRegex() == 1;

  /*  */
  @override
  set max(int max) => _.SetMax(max);
  @override
  int get max => _.GetMax();

  @override
  set offset(int offset) => _.SetOffset(offset);
  @override
  int get offset => _.GetOffset();

  @override
  set replyWindow(HWND hWnd) => _.SetReplyWindow(hWnd);
  @override
  HWND get replyWindow => _.GetReplyWindow();

  @override
  set replyID(int dwId) => _.SetReplyID(dwId);
  @override
  int get replyID => _.GetReplyID();

  @override
  set sort(EverythingSort sortType) => _.SetSort(sortType.val);
  @override
  EverythingSort get sort => EverythingSort.fromVal(_.GetSort());

  @override
  set requestFlags(RequestFlags flags) => _.SetRequestFlags(flags.flags);
  @override
  RequestFlags get requestFlags => RequestFlags.fromFlags(_.GetRequestFlags());

  /// execute query
  @override
  int query(bool wait) => _.QueryW(wait.toInt);

  /// query reply
  @override
  int isQueryReply(
    int message,
    int wParam,
    int lParam,
    int dwId,
  ) =>
      _.IsQueryReply(message, wParam, lParam, dwId);

  @override
  void sortResultsByPath() => _.SortResultsByPath();
  /* get result num */
  @override
  int get numFileResults => _.GetNumFileResults();
  @override
  int get numFolderResults => _.GetNumFolderResults();
  @override
  int get numResults => _.GetNumResults();

  ///  returns the total number of file results.
  ///
  @override
  int get totFileResults => _.GetTotFileResults();
  @override
  int get totFolderResults => _.GetTotFolderResults();
  @override
  int get totResults => _.GetTotResults();
  /* get result info */
  @override
  EverythingSort get resultListSort => EverythingSort.fromVal(_.GetResultListSort());
  @override
  RequestFlags get resultListRequestFlags => RequestFlags.fromFlags(_.GetResultListRequestFlags());
  /* result item type */
  @override
  bool isVolumeResult(int dwIndex) => _.IsVolumeResult(dwIndex) == 1;
  @override
  bool isFolderResult(int dwIndex) => _.IsFolderResult(dwIndex) == 1;
  @override
  bool isFileResult(int dwIndex) => _.IsFileResult(dwIndex) == 1;
  /* result item info */
  @override
  String getResultFileName(int dwIndex) => _.GetResultFileNameW(dwIndex).toDartString();
  @override
  String getResultPath(int dwIndex) => _.GetResultPathW(dwIndex).toDartString();
  @override
  String getResultFullPathName(int dwIndex, {int len = 260, ffi.Allocator allocator = malloc}) {
    LPWSTR buf = allocator<WCHAR>(len + 1);
    _.GetResultFullPathNameW(
      dwIndex,
      buf,
      len,
    );
    final result = buf.toDartString();
    malloc.free(buf);
    return result;
  }

  @override
  String getResultExtension(int dwIndex) => _.GetResultExtensionW(dwIndex).toDartString();
  @override
  int getResultSize(int dwIndex, {ffi.Allocator allocator = malloc}) {
    final lpSize = allocator<LARGE_INTEGER>();
    final ret = _.GetResultSize(dwIndex, lpSize); //todo:

    final size = lpSize.ref.QuadPart;
    allocator.free(lpSize);
    return size;
  }

  DateTime _getFileTime(int dwIndex, int Function(int, ffi.Pointer<FILETIME>) getFileTime,
      {ffi.Allocator allocator = malloc}) {
    final lpDateCreated = allocator<FILETIME>();
    final ret = getFileTime(
      dwIndex,
      lpDateCreated,
    );
    final time = lpDateCreated.ref;
    final datetime = time.utc;
    allocator.free(lpDateCreated);
    return datetime;
  }

  @override
  DateTime getResultDateCreated(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateCreated);
  @override
  DateTime getResultDateModified(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateModified);
  @override
  DateTime getResultDateAccessed(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateAccessed);

  @override
  FileAttribute getResultAttributes(int dwIndex) => FileAttribute(_.GetResultAttributes(dwIndex));
  @override
  String getResultFileListFileName(int dwIndex) => _.GetResultFileListFileNameW(dwIndex).toDartString();
  @override
  int getResultRunCount(int dwIndex) => _.GetResultRunCount(dwIndex);

  @override
  DateTime getResultDateRun(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateRun);
  @override
  DateTime getResultDateRecentlyChanged(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, _.GetResultDateRecentlyChanged);
  @override
  String getResultHighlightedFileName(int dwIndex) => _.GetResultHighlightedFileNameW(dwIndex).toDartString();
  @override
  String getResultHighlightedPath(int dwIndex) => _.GetResultHighlightedPathW(dwIndex).toDartString();
  @override
  String getResultHighlightedFullPathAndFileName(int dwIndex) =>
      _.GetResultHighlightedFullPathAndFileNameW(dwIndex).toDartString();
  @override
  int getRunCountFromFileName(String fileName) {
    final str = fileName.toLPCWSTR();
    final count = _.GetRunCountFromFileNameW(
      str,
    );
    malloc.free(str);
    return count;
  }

  @override
  int setRunCountFromFileName(String fileName, int count) {
    final str = fileName.toLPCWSTR();
    final ret = _.SetRunCountFromFileNameW(str, count);
    malloc.free(str);
    return ret;
  }

  @override
  int incRunCountFromFileName(String fileName) {
    final str = fileName.toLPCWSTR();
    final ret = _.IncRunCountFromFileNameW(str);
    malloc.free(str);
    return ret;
  }

  /*  */
  /// reset state and free any allocated memory
  @override
  void reset() => _.Reset();
  @override
  void cleanUp() => _.CleanUp();
  @override
  void exit() => _.Exit();
  @override
  void isAdmin() => _.IsAdmin();
  @override
  void isAppData() => _.IsAppData();
  /* DB */
  @override
  void isDBLoaded() => _.IsDBLoaded();
  @override
  void rebuildDB() => _.RebuildDB();
  @override
  void updateAllFolderIndexes() => _.UpdateAllFolderIndexes();
  @override
  void saveDB() => _.SaveDB();
  @override
  void saveRunHistory() => _.SaveRunHistory();
  @override
  void deleteRunHistory() => _.DeleteRunHistory();

  /* utils */

  /// run query
  Results runQuery(Query q, {bool setQueryConfig = true}) {
    if (setQueryConfig) setQuery(q);

    /// run query
    query(true);
    final List<ResultItem> items = [];

    final result = Results(
      fileNum: numFileResults,
      folderNum: numFolderResults,
      resultsNum: numResults,
      totFileNum: totFileResults,
      totFolderNum: totFolderResults,
      totResultsNum: totResults,
      requestFlags: resultListRequestFlags,
      sort: resultListSort,
      items: items,
    );

    final resultLen = result.resultsNum;
    final request = result.requestFlags;

    for (var i = 0; i < resultLen; i++) {
      final resultItem = ResultItem.fromRequestFlags(this, request, i);
      items.add(resultItem);
    }
    return result;
  }

  /// set config in [Query]
  void setQuery(Query query) {
    search = query.search;

    /// search mode
    matchCase = query.isMatchCase;
    matchWholeWord = query.isMatchWholeWord;
    matchPath = query.isMatchPath;
    regex = query.isRegex;

    if (query.max != null) max = query.max!;
    if (query.offset != null) offset = query.offset!;
    if (query.replyWindow != null) replyWindow = query.replyWindow!;
    if (query.replyID != null) replyID = query.replyID!;

    sort = query.sort;
    requestFlags = query.requestFlags;
  }
}
