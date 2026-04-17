// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../query/query.dart';
import '../query/results.dart';
import 'error.dart';
import 'everything.g.dart';
import 'everything_api.g.dart';
import 'file_attribute.dart';
import 'file_info_indexed.dart';
import 'request_flags.dart';
import 'sort.dart';
import 'string.dart';
import 'target_machine.dart';

extension on bool {
  int get toInt => this ? 1 : 0;
}

/// microseconds From 1601-1-1 To 1970-1-1
final microsecondsFrom1601To1970 = DateTime.fromMicrosecondsSinceEpoch(
  0,
).difference(DateTime.utc(1601, 1, 1)).inMicroseconds;

/// helper for FILETIME
extension FileTImeHelper on FILETIME {
  /// Contains a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (UTC).
  int get hundredNanoseconds => (dwHighDateTime << 32) + dwLowDateTime;

  /// nanosecond intervals since January 1, 1601 (UTC).
  int get nanosecond => hundredNanoseconds * 100;

  /// trans to DateTime(UTC)
  DateTime get utc => DateTime.fromMicrosecondsSinceEpoch(
    hundredNanoseconds ~/ 10 - microsecondsFrom1601To1970,
  );
}

/// High-level Dart wrapper for the Voidtools Everything SDK.
///
/// This wrapper uses Dart native assets and the bundled prebuilt library
/// selected by the runtime, so no manual DLL loading or initialization is
/// required.
///
/// Help and reference:
/// - English (US): https://www.voidtools.com/en-us/support/everything/sdk/
/// - 简体中文: https://www.voidtools.com/zh-cn/support/everything/sdk/
/// - All supported languages: https://www.voidtools.com/language/
/// - Offline help: https://www.voidtools.com/Everything.chm.zip
class Everything implements EverythingApi {
  /// Creates an SDK wrapper backed by the runtime-resolved native asset.
  const Everything();

  T _withLpcwstr<T>(
    String value,
    T Function(LPCWSTR pointer) action, {
    ffi.Allocator allocator = malloc,
  }) {
    final pointer = value.toLPCWSTR(allocator: allocator);
    try {
      return action(pointer);
    } finally {
      allocator.free(pointer);
    }
  }

  void _checkLastError(int ret, [String? msg]) {
    final err = EverythingErrorCode.fromVal(ret);
    if (err != EverythingErrorCode.ok &&
        err != EverythingErrorCode.errorUnknow) {
      throw EverythingException(err, msg);
    }
  }

  /* API */
  /* version */
  @override
  int get majorVersion => GetMajorVersion();
  @override
  int get minorVersion => GetMinorVersion();
  @override
  int get revision => GetRevision();
  @override
  int get buildNumber => GetBuildNumber();
  @override
  EverythingTargetMachine get targetMachine =>
      EverythingTargetMachine.fromVal(GetTargetMachine());
  /* search */
  @override
  set search(String lpString) => _withLpcwstr(lpString, SetSearchW);
  @override
  String get search => GetSearchW().toDartString();

  @override
  int get lastError => GetLastError();

  /* search mode */
  @override
  set matchCase(bool bEnable) => SetMatchCase(bEnable.toInt);
  @override
  bool get matchCase => GetMatchCase() != 0;

  @override
  set matchWholeWord(bool bEnable) => SetMatchWholeWord(bEnable.toInt);
  @override
  bool get matchWholeWord => GetMatchWholeWord() != 0;

  @override
  set matchPath(bool bEnable) => SetMatchPath(bEnable.toInt);
  @override
  bool get matchPath => GetMatchPath() != 0;

  @override
  set regex(bool bEnable) => SetRegex(bEnable.toInt);
  @override
  bool get regex => GetRegex() != 0;

  @override
  bool isFastSort(EverythingSort sortType) => IsFastSort(sortType.val) != 0;

  @override
  bool isFileInfoIndexed(FileInfoIndexed fileInfoType) =>
      IsFileInfoIndexed(fileInfoType.value) != 0;
  /*  */
  @override
  set max(int max) => SetMax(max);
  @override
  int get max => GetMax();

  @override
  set offset(int offset) => SetOffset(offset);
  @override
  int get offset => GetOffset();

  @override
  set replyWindow(HWND hWnd) => SetReplyWindow(hWnd);
  @override
  HWND get replyWindow => GetReplyWindow();

  @override
  set replyID(int dwId) => SetReplyID(dwId);
  @override
  int get replyID => GetReplyID();

  @override
  set sort(EverythingSort sortType) => SetSort(sortType.val);
  @override
  EverythingSort get sort => EverythingSort.fromVal(GetSort());

  @override
  set requestFlags(RequestFlags flags) => SetRequestFlags(flags.flags);
  @override
  RequestFlags get requestFlags => RequestFlags.fromFlags(GetRequestFlags());

  @override
  bool query(bool wait) => QueryW(wait.toInt) != 0;

  @override
  bool isQueryReply(int message, int wParam, int lParam, int dwId) =>
      IsQueryReply(message, wParam, lParam, dwId) != 0;

  @override
  void sortResultsByPath() => SortResultsByPath();
  /* get result num */
  @override
  int get numFileResults => GetNumFileResults();
  @override
  int get numFolderResults => GetNumFolderResults();
  @override
  int get numResults => GetNumResults();

  @override
  int get totFileResults => GetTotFileResults();
  @override
  int get totFolderResults => GetTotFolderResults();
  @override
  int get totResults => GetTotResults();
  /* get result info */
  @override
  EverythingSort get resultListSort =>
      EverythingSort.fromVal(GetResultListSort());
  @override
  RequestFlags get resultListRequestFlags =>
      RequestFlags.fromFlags(GetResultListRequestFlags());
  /* result item type */
  @override
  bool isVolumeResult(int dwIndex) => IsVolumeResult(dwIndex) != 0;
  @override
  bool isFolderResult(int dwIndex) => IsFolderResult(dwIndex) != 0;
  @override
  bool isFileResult(int dwIndex) => IsFileResult(dwIndex) != 0;
  /* result item info */
  @override
  String getResultFileName(int dwIndex) =>
      GetResultFileNameW(dwIndex).toDartString();
  @override
  String getResultPath(int dwIndex) => GetResultPathW(dwIndex).toDartString();
  @override
  String getResultFullPathName(
    int dwIndex, {
    int len = 260,
    ffi.Allocator allocator = malloc,
  }) {
    LPWSTR buf = allocator<WCHAR>(len + 1);
    GetResultFullPathNameW(dwIndex, buf, len);
    final result = buf.toDartString();
    allocator.free(buf);
    return result;
  }

  @override
  String getResultExtension(int dwIndex) =>
      GetResultExtensionW(dwIndex).toDartString();
  @override
  int getResultSize(int dwIndex, {ffi.Allocator allocator = malloc}) {
    final lpSize = allocator<LARGE_INTEGER>();
    final ret = GetResultSize(dwIndex, lpSize);
    if (ret == 0) _checkLastError(lastError, 'getResultSize');
    final size = lpSize.ref.QuadPart;
    allocator.free(lpSize);
    return size;
  }

  DateTime _getFileTime(
    int dwIndex,
    int Function(int, ffi.Pointer<FILETIME>) getFileTime,
    String? errorMessage, {
    ffi.Allocator allocator = malloc,
  }) {
    final lpDateCreated = allocator<FILETIME>();
    final ret = getFileTime(dwIndex, lpDateCreated);
    if (ret == 0) _checkLastError(lastError, errorMessage);
    final time = lpDateCreated.ref;
    final datetime = time.utc;
    allocator.free(lpDateCreated);
    return datetime;
  }

  @override
  DateTime getResultDateCreated(
    int dwIndex, {
    ffi.Allocator allocator = malloc,
  }) => _getFileTime(dwIndex, GetResultDateCreated, 'getResultDateCreated');
  @override
  DateTime getResultDateModified(
    int dwIndex, {
    ffi.Allocator allocator = malloc,
  }) => _getFileTime(dwIndex, GetResultDateModified, 'getResultDateModified');
  @override
  DateTime getResultDateAccessed(
    int dwIndex, {
    ffi.Allocator allocator = malloc,
  }) => _getFileTime(dwIndex, GetResultDateAccessed, 'getResultDateAccessed');

  @override
  FileAttribute getResultAttributes(int dwIndex) =>
      FileAttribute(GetResultAttributes(dwIndex));
  @override
  String getResultFileListFileName(int dwIndex) =>
      GetResultFileListFileNameW(dwIndex).toDartString();
  @override
  int getResultRunCount(int dwIndex) => GetResultRunCount(dwIndex);

  @override
  DateTime getResultDateRun(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, GetResultDateRun, 'getResultDateRun');
  @override
  DateTime getResultDateRecentlyChanged(
    int dwIndex, {
    ffi.Allocator allocator = malloc,
  }) => _getFileTime(
    dwIndex,
    GetResultDateRecentlyChanged,
    'getResultDateRecentlyChanged',
  );
  @override
  String getResultHighlightedFileName(int dwIndex) =>
      GetResultHighlightedFileNameW(dwIndex).toDartString();
  @override
  String getResultHighlightedPath(int dwIndex) =>
      GetResultHighlightedPathW(dwIndex).toDartString();
  @override
  String getResultHighlightedFullPathAndFileName(int dwIndex) =>
      GetResultHighlightedFullPathAndFileNameW(dwIndex).toDartString();
  @override
  int getRunCountFromFileName(String fileName) =>
      _withLpcwstr(fileName, GetRunCountFromFileNameW);

  @override
  bool setRunCountFromFileName(String fileName, int count) =>
      _withLpcwstr(fileName, (str) => SetRunCountFromFileNameW(str, count)) !=
      0;

  @override
  int incRunCountFromFileName(String fileName) =>
      _withLpcwstr(fileName, IncRunCountFromFileNameW);

  /*  */
  @override
  void reset() => Reset();
  @override
  void cleanUp() => CleanUp();
  @override
  bool exit() => Exit() != 0;
  @override
  @Deprecated('no longer used, remove.')
  int msiExitAndStopService(ffi.Pointer<ffi.Void> msihandle) =>
      MSIExitAndStopService(msihandle);
  @override
  @Deprecated('no longer used, remove.')
  int msiStartService(ffi.Pointer<ffi.Void> msihandle) =>
      MSIStartService(msihandle);
  @override
  bool isAdmin() => IsAdmin() != 0;
  @override
  bool isAppData() => IsAppData() != 0;
  /* DB */
  @override
  bool isDBLoaded() => IsDBLoaded() != 0;
  @override
  bool rebuildDB() => RebuildDB() != 0;
  @override
  bool updateAllFolderIndexes() => UpdateAllFolderIndexes() != 0;
  @override
  bool saveDB() => SaveDB() != 0;
  @override
  bool saveRunHistory() => SaveRunHistory() != 0;
  @override
  bool deleteRunHistory() => DeleteRunHistory() != 0;

  /* utils */

  /// run query
  Results runQuery(Query q, {bool setQueryConfig = true}) {
    if (setQueryConfig) setQuery(q);

    /// run query
    query(true);

    final request = resultListRequestFlags;
    final resultLen = numResults;
    final items = List<ResultItem>.generate(
      resultLen,
      (index) => ResultItem.fromRequestFlags(this, request, index),
      growable: false,
    );

    return Results(
      fileNum: numFileResults,
      folderNum: numFolderResults,
      resultsNum: resultLen,
      totFileNum: totFileResults,
      totFolderNum: totFolderResults,
      totResultsNum: totResults,
      requestFlags: request,
      sort: resultListSort,
      items: items,
    );
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
