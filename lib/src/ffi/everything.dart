// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

import '../assets.dart';
import 'everything.g.dart';
import 'string.dart';

typedef GetFileTime = int Function(
  int dwIndex,
  ffi.Pointer<FILETIME> lpDateModified,
);

extension on bool {
  int get toInt => this ? 1 : 0;
}

class Everything {
  final EverythingBase e;

  Everything(ffi.DynamicLibrary dynamicLibrary) : e = EverythingBase(dynamicLibrary);
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
  Everything.fromLookup(ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) lookup)
      : e = EverythingBase.fromLookup(lookup);

  /* API */
  /* version */
  void getMajorVersion() => e.GetMajorVersion();
  void getMinorVersion() => e.GetMinorVersion();
  void getRevision() => e.GetRevision();
  void getBuildNumber() => e.GetBuildNumber();
  void getTargetMachine() => e.GetTargetMachine();
  /* search */
  /// write search state
  set search(String lpString) => e.SetSearchW(lpString.toLPCWSTR());
  String get search => e.GetSearchW().toDartString();

  int get lastError => e.GetLastError();

  /* search mode */
  set matchCase(bool bEnable) => e.SetMatchCase(bEnable.toInt);
  bool get matchCase => e.GetMatchCase() == 1;

  set matchWholeWord(bool bEnable) => e.SetMatchWholeWord(bEnable.toInt);
  bool get matchWholeWord => e.GetMatchWholeWord() == 1;

  set matchPath(bool bEnable) => e.SetMatchPath(bEnable.toInt);
  bool get matchPath => e.GetMatchPath() == 1;

  set regex(bool bEnable) => e.SetRegex(bEnable.toInt);
  bool get regex => e.GetRegex() == 1;

  /*  */
  set max(int max) => e.SetMax(max);
  int get max => e.GetMax();

  set offset(int offset) => e.SetOffset(offset);
  int get offset => e.GetOffset();

  set replyWindow(HWND hWnd) => e.SetReplyWindow(hWnd);
  HWND get replyWindow => e.GetReplyWindow();

  set replyID(int dwId) => e.SetReplyID(dwId);
  int get replyID => e.GetReplyID();

  set sort(EverythingSort sortType) => e.SetSort(sortType.val);
  EverythingSort get sort => EverythingSort.fromVal(e.GetSort());

  set requestFlags(RequestFlags flags) => e.SetRequestFlags(flags.flags);
  RequestFlags get requestFlags => RequestFlags.fromFlags(e.GetRequestFlags());

  /// execute query
  int query(bool wait) => e.QueryW(wait.toInt);

  /// query reply
  int isQueryReply(
    int message,
    int wParam,
    int lParam,
    int dwId,
  ) =>
      e.IsQueryReply(message, wParam, lParam, dwId);

  void sortResultsByPath() => e.SortResultsByPath();
  /* get result num */
  int getNumFileResults() => e.GetNumFileResults();
  int getNumFolderResults() => e.GetNumFolderResults();
  int getNumResults() => e.GetNumResults();

  ///  returns the total number of file results.
  ///
  int getTotFileResults() => e.GetTotFileResults();
  int getTotFolderResults() => e.GetTotFolderResults();
  int getTotResults() => e.GetTotResults();
  /* get result info */
  int getResultListSort() => e.GetResultListSort();
  RequestFlags getResultListRequestFlags() => RequestFlags.fromFlags(e.GetResultListRequestFlags());
  /* result item type */
  bool isVolumeResult(int dwIndex) => e.IsVolumeResult(dwIndex) == 1;
  int isFolderResult(int dwIndex) => e.IsFolderResult(dwIndex);
  int isFileResult(int dwIndex) => e.IsFileResult(dwIndex);
  /* result item info */
  String getResultFileName(int dwIndex) => e.GetResultFileNameW(dwIndex).toDartString();
  String getResultPath(int dwIndex) => e.GetResultPathW(dwIndex).toDartString();
  String getResultFullPathName(int dwIndex, {int len = 260, ffi.Allocator allocator = malloc}) {
    LPWSTR buf = allocator<WCHAR>(len + 1);
    e.GetResultFullPathNameW(
      dwIndex,
      buf,
      len,
    );
    final result = buf.toDartString();
    malloc.free(buf);
    return result;
  }

  String getResultExtension(int dwIndex) => e.GetResultExtensionW(dwIndex).toDartString();
  int getResultSize(int dwIndex, {ffi.Allocator allocator = malloc}) {
    final lpSize = allocator<LARGE_INTEGER>();
    final ret = e.GetResultSize(dwIndex, lpSize); //todo:

    final size = lpSize.ref.QuadPart;
    allocator.free(lpSize);
    return size;
  }

  DateTime _getFileTime(int dwIndex, GetFileTime getFileTime, {ffi.Allocator allocator = malloc}) {
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

  DateTime getResultDateCreated(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, e.GetResultDateCreated);
  DateTime getResultDateModified(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, e.GetResultDateModified);
  DateTime getResultDateAccessed(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, e.GetResultDateAccessed);

  int getResultAttributes(int dwIndex) => e.GetResultAttributes(dwIndex);
  String getResultFileListFileName(int dwIndex) => e.GetResultFileListFileNameW(dwIndex).toDartString();
  int getResultRunCount(int dwIndex) => e.GetResultRunCount(dwIndex);

  DateTime getResultDateRun(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, e.GetResultDateRun);
  DateTime getResultDateRecentlyChanged(int dwIndex, {ffi.Allocator allocator = malloc}) =>
      _getFileTime(dwIndex, e.GetResultDateRecentlyChanged);
  String getResultHighlightedFileName(int dwIndex) => e.GetResultHighlightedFileNameW(dwIndex).toDartString();
  String getResultHighlightedPath(int dwIndex) => e.GetResultHighlightedPathW(dwIndex).toDartString();
  String getResultHighlightedFullPathAndFileName(int dwIndex) =>
      e.GetResultHighlightedFullPathAndFileNameW(dwIndex).toDartString();
  int getRunCountFromFileName(String fileName) {
    final str = fileName.toLPCWSTR();
    final count = e.GetRunCountFromFileNameW(
      str,
    );
    malloc.free(str);
    return count;
  }

  int setRunCountFromFileName(String fileName, int count) {
    final str = fileName.toLPCWSTR();
    final ret = e.SetRunCountFromFileNameW(str, count);
    malloc.free(str);
    return ret;
  }

  int incRunCountFromFileName(String fileName) {
    final str = fileName.toLPCWSTR();
    final ret = e.IncRunCountFromFileNameW(str);
    malloc.free(str);
    return ret;
  }

  /*  */
  /// reset state and free any allocated memory
  void reset() => e.Reset();
  void cleanUp() => e.CleanUp();
  void exit() => e.Exit();
  void isAdmin() => e.IsAdmin();
  void isAppData() => e.IsAppData();
  /* DB */
  void isDBLoaded() => e.IsDBLoaded();
  void rebuildDB() => e.RebuildDB();
  void updateAllFolderIndexes() => e.UpdateAllFolderIndexes();
  void saveDB() => e.SaveDB();
  void saveRunHistory() => e.SaveRunHistory();
  void deleteRunHistory() => e.DeleteRunHistory();

  /* utils */
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
    final flags = getResultListRequestFlags();
    final resultLen = getNumResults();
    final fileNum = getNumFileResults();
    final folderNum = getNumFolderResults();
    final totfile = getTotFileResults();
    final totFolder = getTotFolderResults();
    final tot = getTotResults();
    for (var i = 0; i < resultLen; i++) {
      final size = getResultSize(i);

      final filename = getResultFileName(i);
      final path = getResultPath(i);

      print('$i Name: $filename, Path: $path, Size: $size');
    }
  }
}

enum EverythingError implements Comparable<EverythingError> {
  ok(EVERYTHING_OK),
  errorMemory(EVERYTHING_ERROR_MEMORY),
  errorIpc(EVERYTHING_ERROR_IPC),
  errorRegisterclassex(EVERYTHING_ERROR_REGISTERCLASSEX),
  errorCreatewindow(EVERYTHING_ERROR_CREATEWINDOW),
  errorCreatethread(EVERYTHING_ERROR_CREATETHREAD),
  errorInvalidindex(EVERYTHING_ERROR_INVALIDINDEX),
  errorInvalidcall(EVERYTHING_ERROR_INVALIDCALL),
  errorInvalidrequest(EVERYTHING_ERROR_INVALIDREQUEST),
  errorInvalidparameter(EVERYTHING_ERROR_INVALIDPARAMETER),

  ///
  errorUnknow(-1);

  final int val;
  const EverythingError(this.val);
  factory EverythingError.fromVal(int val) {
    switch (val) {
      case EVERYTHING_OK:
        return ok;
      case EVERYTHING_ERROR_MEMORY:
        return errorMemory;
      case EVERYTHING_ERROR_IPC:
        return errorIpc;
      case EVERYTHING_ERROR_REGISTERCLASSEX:
        return errorRegisterclassex;
      case EVERYTHING_ERROR_CREATEWINDOW:
        return errorCreatewindow;
      case EVERYTHING_ERROR_CREATETHREAD:
        return errorCreatethread;
      case EVERYTHING_ERROR_INVALIDINDEX:
        return errorInvalidindex;
      case EVERYTHING_ERROR_INVALIDCALL:
        return errorInvalidcall;
      case EVERYTHING_ERROR_INVALIDREQUEST:
        return errorInvalidrequest;
      case EVERYTHING_ERROR_INVALIDPARAMETER:
        return errorInvalidparameter;
      default:
        return errorUnknow;
    }
  }
  @override
  int compareTo(EverythingError other) => val - other.val;
}

enum EverythingSort implements Comparable<EverythingSort> {
  nameAscending(EVERYTHING_SORT_NAME_ASCENDING),
  nameDescending(EVERYTHING_SORT_NAME_DESCENDING),
  pathAscending(EVERYTHING_SORT_PATH_ASCENDING),
  pathDescending(EVERYTHING_SORT_PATH_DESCENDING),
  sizeAscending(EVERYTHING_SORT_SIZE_ASCENDING),
  sizeDescending(EVERYTHING_SORT_SIZE_DESCENDING),
  extensionAscending(EVERYTHING_SORT_EXTENSION_ASCENDING),
  extensionDescending(EVERYTHING_SORT_EXTENSION_DESCENDING),
  typeNameAscending(EVERYTHING_SORT_TYPE_NAME_ASCENDING),
  typeNameDescending(EVERYTHING_SORT_TYPE_NAME_DESCENDING),
  dateCreatedAscending(EVERYTHING_SORT_DATE_CREATED_ASCENDING),
  dateCreatedDescending(EVERYTHING_SORT_DATE_CREATED_DESCENDING),
  dateModifiedAscending(EVERYTHING_SORT_DATE_MODIFIED_ASCENDING),
  dateModifiedDescending(EVERYTHING_SORT_DATE_MODIFIED_DESCENDING),
  attributesAscending(EVERYTHING_SORT_ATTRIBUTES_ASCENDING),
  attributesDescending(EVERYTHING_SORT_ATTRIBUTES_DESCENDING),
  fileListFilenameAscending(EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING),
  fileListFilenameDescending(EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING),
  runCountAscending(EVERYTHING_SORT_RUN_COUNT_ASCENDING),
  runCountDescending(EVERYTHING_SORT_RUN_COUNT_DESCENDING),
  dateRecentlyChangedAscending(EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING),
  dateRecentlyChangedDescending(EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING),
  dateAccessedAscending(EVERYTHING_SORT_DATE_ACCESSED_ASCENDING),
  dateAccessedDescending(EVERYTHING_SORT_DATE_ACCESSED_DESCENDING),
  dateRunAscending(EVERYTHING_SORT_DATE_RUN_ASCENDING),
  dateRunDescending(EVERYTHING_SORT_DATE_RUN_DESCENDING),

  ///
  unknow(-1);

  final int val;
  const EverythingSort(this.val);
  factory EverythingSort.fromVal(int val) {
    switch (val) {
      case EVERYTHING_SORT_NAME_ASCENDING:
        return nameAscending;
      case EVERYTHING_SORT_NAME_DESCENDING:
        return nameDescending;
      case EVERYTHING_SORT_PATH_ASCENDING:
        return pathAscending;
      case EVERYTHING_SORT_PATH_DESCENDING:
        return pathDescending;
      case EVERYTHING_SORT_SIZE_ASCENDING:
        return sizeAscending;
      case EVERYTHING_SORT_SIZE_DESCENDING:
        return sizeDescending;
      case EVERYTHING_SORT_EXTENSION_ASCENDING:
        return extensionAscending;
      case EVERYTHING_SORT_EXTENSION_DESCENDING:
        return extensionDescending;
      case EVERYTHING_SORT_TYPE_NAME_ASCENDING:
        return typeNameAscending;
      case EVERYTHING_SORT_TYPE_NAME_DESCENDING:
        return typeNameDescending;
      case EVERYTHING_SORT_DATE_CREATED_ASCENDING:
        return dateCreatedAscending;
      case EVERYTHING_SORT_DATE_CREATED_DESCENDING:
        return dateCreatedDescending;
      case EVERYTHING_SORT_DATE_MODIFIED_ASCENDING:
        return dateModifiedAscending;
      case EVERYTHING_SORT_DATE_MODIFIED_DESCENDING:
        return dateModifiedDescending;
      case EVERYTHING_SORT_ATTRIBUTES_ASCENDING:
        return attributesAscending;
      case EVERYTHING_SORT_ATTRIBUTES_DESCENDING:
        return attributesDescending;
      case EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING:
        return fileListFilenameAscending;
      case EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING:
        return fileListFilenameDescending;
      case EVERYTHING_SORT_RUN_COUNT_ASCENDING:
        return runCountAscending;
      case EVERYTHING_SORT_RUN_COUNT_DESCENDING:
        return runCountDescending;
      case EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING:
        return dateRecentlyChangedAscending;
      case EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING:
        return dateRecentlyChangedDescending;
      case EVERYTHING_SORT_DATE_ACCESSED_ASCENDING:
        return dateAccessedAscending;
      case EVERYTHING_SORT_DATE_ACCESSED_DESCENDING:
        return dateAccessedDescending;
      case EVERYTHING_SORT_DATE_RUN_ASCENDING:
        return dateRunAscending;
      case EVERYTHING_SORT_DATE_RUN_DESCENDING:
        return dateRunDescending;
      default:
        return unknow;
    }
  }
  @override
  int compareTo(EverythingSort other) => val - other.val;
}

class RequestFlags {
  final bool fileName;
  final bool path;
  final bool fullPathAndFileName;
  final bool extension;
  final bool size;
  final bool dateCreated;
  final bool dateModified;
  final bool dateAccessed;
  final bool attributes;
  final bool fileListFileName;
  final bool runCount;
  final bool dateRun;
  final bool dateRecentlyChanged;
  final bool highlightedFileName;
  final bool highlightedPath;
  final bool highlightedFullPathAndFileName;
  RequestFlags({
    this.fileName = false,
    this.path = false,
    this.fullPathAndFileName = false,
    this.extension = false,
    this.size = false,
    this.dateCreated = false,
    this.dateModified = false,
    this.dateAccessed = false,
    this.attributes = false,
    this.fileListFileName = false,
    this.runCount = false,
    this.dateRun = false,
    this.dateRecentlyChanged = false,
    this.highlightedFileName = false,
    this.highlightedPath = false,
    this.highlightedFullPathAndFileName = false,
  });
  factory RequestFlags.fromFlags(int flags) => RequestFlags(
        fileName: flags & EVERYTHING_REQUEST_FILE_NAME != 0,
        path: flags & EVERYTHING_REQUEST_PATH != 0,
        fullPathAndFileName: flags & EVERYTHING_REQUEST_FULL_PATH_AND_FILE_NAME != 0,
        extension: flags & EVERYTHING_REQUEST_EXTENSION != 0,
        size: flags & EVERYTHING_REQUEST_SIZE != 0,
        dateCreated: flags & EVERYTHING_REQUEST_DATE_CREATED != 0,
        dateModified: flags & EVERYTHING_REQUEST_DATE_MODIFIED != 0,
        dateAccessed: flags & EVERYTHING_REQUEST_DATE_ACCESSED != 0,
        attributes: flags & EVERYTHING_REQUEST_ATTRIBUTES != 0,
        fileListFileName: flags & EVERYTHING_REQUEST_FILE_LIST_FILE_NAME != 0,
        runCount: flags & EVERYTHING_REQUEST_RUN_COUNT != 0,
        dateRun: flags & EVERYTHING_REQUEST_DATE_RUN != 0,
        dateRecentlyChanged: flags & EVERYTHING_REQUEST_DATE_RECENTLY_CHANGED != 0,
        highlightedFileName: flags & EVERYTHING_REQUEST_HIGHLIGHTED_FILE_NAME != 0,
        highlightedPath: flags & EVERYTHING_REQUEST_HIGHLIGHTED_PATH != 0,
        highlightedFullPathAndFileName: flags & EVERYTHING_REQUEST_HIGHLIGHTED_FULL_PATH_AND_FILE_NAME != 0,
      );

  int get flags =>
      (fileName ? EVERYTHING_REQUEST_FILE_NAME : 0) |
      (path ? EVERYTHING_REQUEST_PATH : 0) |
      (fullPathAndFileName ? EVERYTHING_REQUEST_FULL_PATH_AND_FILE_NAME : 0) |
      (extension ? EVERYTHING_REQUEST_EXTENSION : 0) |
      (size ? EVERYTHING_REQUEST_SIZE : 0) |
      (dateCreated ? EVERYTHING_REQUEST_DATE_CREATED : 0) |
      (dateModified ? EVERYTHING_REQUEST_DATE_MODIFIED : 0) |
      (dateAccessed ? EVERYTHING_REQUEST_DATE_ACCESSED : 0) |
      (attributes ? EVERYTHING_REQUEST_ATTRIBUTES : 0) |
      (fileListFileName ? EVERYTHING_REQUEST_FILE_LIST_FILE_NAME : 0) |
      (runCount ? EVERYTHING_REQUEST_RUN_COUNT : 0) |
      (dateRun ? EVERYTHING_REQUEST_DATE_RUN : 0) |
      (dateRecentlyChanged ? EVERYTHING_REQUEST_DATE_RECENTLY_CHANGED : 0) |
      (highlightedFileName ? EVERYTHING_REQUEST_HIGHLIGHTED_FILE_NAME : 0) |
      (highlightedPath ? EVERYTHING_REQUEST_HIGHLIGHTED_PATH : 0) |
      (highlightedFullPathAndFileName ? EVERYTHING_REQUEST_HIGHLIGHTED_FULL_PATH_AND_FILE_NAME : 0);
}
