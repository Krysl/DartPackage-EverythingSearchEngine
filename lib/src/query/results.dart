import '../ffi/everything.dart';
import '../ffi/file_attribute.dart';
import '../ffi/request_flags.dart';
import '../ffi/sort.dart';

/// to save result item
class ResultItem {
  /// result is a volume.
  late final bool? isVolumn;

  /// result is a folder.
  late final bool? isFolder;

  /// result is a file.
  late final bool? isFile;

  /// get result using [Everything.getResultFileName]
  late final String? filename;

  /// get result using [Everything.getResultPath]
  late final String? path;

  /// get result using [Everything.getResultFullPathName]
  late final String? extension;

  /// get result using [Everything.getResultExtension]
  late final String? fullPathName;

  /// get result using [Everything.getResultSize]
  late final int? size;

  /// get result using [Everything.getResultDateCreated]
  late final DateTime? dateCreated;

  /// get result using [Everything.getResultDateModified]
  late final DateTime? dateModified;

  /// get result using [Everything.getResultDateAccessed]
  late final DateTime? dateAccessed;

  /// get result using [Everything.getResultDateRecentlyChanged]
  late final DateTime? dateRecentlyChanged;

  /// get result using [Everything.getResultDateRun]
  late final DateTime? dateRun;

  /// get result using [Everything.getResultAttributes]
  late final FileAttribute? attributes;

  /// get result using [Everything.getResultFileListFileName]
  late final String? fileListFileName;

  /// get result using [Everything.getResultRunCount]
  late final int? runCount;

  /// get result using [Everything.getResultHighlightedFileName]
  late final String? highlightedFileName;

  /// get result using [Everything.getResultHighlightedPath]
  late final String? highlightedPath;

  /// get result using [Everything.getResultHighlightedFullPathAndFileName]
  late final String? highlightedFullPathAndFileName;

  /// get result items using [RequestFlags]
  ResultItem.fromRequestFlags(
    Everything e,
    RequestFlags flags,
    int index,
  ) {
    if (flags.kind) {
      final isFile_ = e.isFileResult(index);
      isFile = isFile_;
      if (isFile_) {
        isVolumn = false;
        isFolder = false;
      } else {
        final isFolder_ = e.isFolderResult(index);
        isFolder = isFolder_;
        if (!isFolder_) {
          isVolumn = e.isVolumeResult(index);
        }
      }
    }
    filename = flags.fileName ? e.getResultFileName(index) : null;
    path = flags.path ? e.getResultPath(index) : null;
    fullPathName = flags.fullPathAndFileName ? e.getResultFullPathName(index) : null;
    extension = flags.extension ? e.getResultExtension(index) : null;
    size = flags.size ? e.getResultSize(index) : null;
    dateCreated = flags.dateCreated ? e.getResultDateCreated(index) : null;
    dateModified = flags.dateModified ? e.getResultDateModified(index) : null;
    dateAccessed = flags.dateAccessed ? e.getResultDateAccessed(index) : null;
    attributes = flags.attributes ? e.getResultAttributes(index) : null;
    fileListFileName = flags.fileListFileName ? e.getResultFileListFileName(index) : null;
    runCount = flags.runCount ? e.getResultRunCount(index) : null;
    dateRun = flags.dateRun ? e.getResultDateRun(index) : null;
    dateRecentlyChanged = flags.dateRecentlyChanged ? e.getResultDateRecentlyChanged(index) : null;
    highlightedFileName = flags.highlightedFileName ? e.getResultHighlightedFileName(index) : null;
    highlightedPath = flags.highlightedPath ? e.getResultHighlightedPath(index) : null;
    highlightedFullPathAndFileName =
        flags.highlightedFullPathAndFileName ? e.getResultHighlightedFullPathAndFileName(index) : null;
  }
  @override
  String toString() {
    final strbuf = StringBuffer();
    if (filename != null) strbuf.write('filename: $filename, ');
    if (path != null) strbuf.write('path: $path, ');
    if (fullPathName != null) strbuf.write('fullPathName: $fullPathName, ');
    if (extension != null) strbuf.write('extension: $extension, ');
    if (size != null) strbuf.write('size: $size, ');
    if (dateCreated != null) strbuf.write('dateCreated: $dateCreated, ');
    if (dateModified != null) strbuf.write('dateModified: $dateModified, ');
    if (dateAccessed != null) strbuf.write('dateAccessed: $dateAccessed, ');
    if (attributes != null) strbuf.write('attributes: $attributes, ');
    if (fileListFileName != null) strbuf.write('fileListFileName: $fileListFileName, ');
    if (runCount != null) strbuf.write('runCount: $runCount, ');
    if (dateRun != null) strbuf.write('dateRun: $dateRun, ');
    if (dateRecentlyChanged != null) strbuf.write('dateRecentlyChanged: $dateRecentlyChanged, ');
    if (highlightedFileName != null) strbuf.write('highlightedFileName: $highlightedFileName, ');
    if (highlightedPath != null) strbuf.write('highlightedPath: $highlightedPath, ');
    if (highlightedFullPathAndFileName != null) {
      strbuf.write('highlightedFullPathAndFileName: $highlightedFullPathAndFileName, ');
    }

    return strbuf.toString();
  }
}

/// store results
class Results {
  /// [Everything.numFileResults]
  final int fileNum;

  /// [Everything.numFolderResults]
  final int folderNum;

  /// [Everything.numResults]
  final int resultsNum;

  /// [Everything.totFileResults]
  final int totFileNum;

  /// [Everything.totFolderResults]
  final int totFolderNum;

  /// [Everything.totResults]
  final int totResultsNum;

  /// [Everything.requestFlags]
  final RequestFlags requestFlags;

  /// [Everything.resultListSort]
  final EverythingSort sort;

  /// the result items
  final List<ResultItem> items;

  /// create Results
  const Results({
    required this.fileNum,
    required this.folderNum,
    required this.resultsNum,
    required this.totFileNum,
    required this.totFolderNum,
    required this.totResultsNum,
    required this.requestFlags,
    required this.sort,
    required this.items,
  });
}
