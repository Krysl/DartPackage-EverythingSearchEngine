// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

import '../assets.dart';
import 'everything.g.dart';
import 'everything_api.g.dart';
import 'request_flags.dart';
import 'sort.dart';
import 'string.dart';
import 'target_machine.dart';

extension on bool {
  int get toInt => this ? 1 : 0;
}

class Everything implements EverythingApi {
  final EverythingBase _;

  /// The symbols are looked up in [dynamicLibrary].
  Everything(ffi.DynamicLibrary dynamicLibrary) : _ = EverythingBase(dynamicLibrary);

  factory Everything.fromLibraryPath(String libraryPath) {
    assert(File(libraryPath).existsSync(), 'file $libraryPath not exist in ${Directory.current}');
    return Everything(ffi.DynamicLibrary.open(libraryPath));
  }
  factory Everything.fromDefaultLibraryPath({
    /// use only in development of this package
    bool isLocalTest = false,

    /// use in test for common user
    bool isTest = false,
  }) =>
      Everything.fromLibraryPath(
        path.normalize(
          path.join(
            isLocalTest ? '' : (isTest ? 'build/flutter_assets' : 'data/flutter_assets'),
            Assets.everything_search_engine$Everything64_dll,
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
  int get resultListSort => _.GetResultListSort();
  @override
  RequestFlags get resultListRequestFlags => RequestFlags.fromFlags(_.GetResultListRequestFlags());
  /* result item type */
  @override
  bool isVolumeResult(int dwIndex) => _.IsVolumeResult(dwIndex) == 1;
  @override
  int isFolderResult(int dwIndex) => _.IsFolderResult(dwIndex);
  @override
  int isFileResult(int dwIndex) => _.IsFileResult(dwIndex);
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
    final datetime = DateTime(2020);
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
  int getResultAttributes(int dwIndex) => _.GetResultAttributes(dwIndex);
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
  @override
  void runQuery(
    String q, {
    bool isMatchCase = false,
    bool isMatchWholeWord = false,
    bool isRegex = false,
    bool isMatchPath = false,
    RequestFlags? requestFlags,
    EverythingSort sort = EverythingSort.sizeAscending,
  }) {
    search = q;
    this.requestFlags = requestFlags ??
        RequestFlags(
          fileName: true,
          path: true,
          size: true,
        );
    this.sort = sort;

    /// search mode
    matchCase = isMatchCase;
    matchWholeWord = isMatchWholeWord;
    matchPath = isMatchPath;
    regex = isRegex;

    /// run query
    query(true);
    final flags = resultListRequestFlags;
    final resultLen = numResults;
    final fileNum = numFileResults;
    final folderNum = numFolderResults;
    final totfile = totFileResults;
    final totFolder = totFolderResults;
    final tot = totResults;
    for (var i = 0; i < resultLen; i++) {
      final size = getResultSize(i);

      final filename = getResultFileName(i);
      final path = getResultPath(i);

      print('$i Name: $filename, Path: $path, Size: $size');
    }
  }
}
