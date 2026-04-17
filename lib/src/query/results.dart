import 'package:meta/meta.dart';

import '../ffi/everything.dart';
import '../ffi/file_attribute.dart';
import '../ffi/request_flags.dart';
import '../ffi/sort.dart';

/// to save result item
@immutable
class ResultItem {
  /// result is a volume.
  final bool? isVolumn;

  /// result is a folder.
  final bool? isFolder;

  /// result is a file.
  final bool? isFile;

  /// get result using [Everything.getResultFileName]
  final String? filename;

  /// get result using [Everything.getResultPath]
  final String? path;

  /// get result using [Everything.getResultFullPathName]
  final String? extension;

  /// get result using [Everything.getResultExtension]
  final String? fullPathName;

  /// get result using [Everything.getResultSize]
  final int? size;

  /// get result using [Everything.getResultDateCreated]
  final DateTime? dateCreated;

  /// get result using [Everything.getResultDateModified]
  final DateTime? dateModified;

  /// get result using [Everything.getResultDateAccessed]
  final DateTime? dateAccessed;

  /// get result using [Everything.getResultDateRecentlyChanged]
  final DateTime? dateRecentlyChanged;

  /// get result using [Everything.getResultDateRun]
  final DateTime? dateRun;

  /// get result using [Everything.getResultAttributes]
  final FileAttribute? attributes;

  /// get result using [Everything.getResultFileListFileName]
  final String? fileListFileName;

  /// get result using [Everything.getResultRunCount]
  final int? runCount;

  /// get result using [Everything.getResultHighlightedFileName]
  final String? highlightedFileName;

  /// get result using [Everything.getResultHighlightedPath]
  final String? highlightedPath;

  /// get result using [Everything.getResultHighlightedFullPathAndFileName]
  final String? highlightedFullPathAndFileName;

  const ResultItem._({
    this.isVolumn,
    this.isFolder,
    this.isFile,
    this.filename,
    this.path,
    this.extension,
    this.fullPathName,
    this.size,
    this.dateCreated,
    this.dateModified,
    this.dateAccessed,
    this.dateRecentlyChanged,
    this.dateRun,
    this.attributes,
    this.fileListFileName,
    this.runCount,
    this.highlightedFileName,
    this.highlightedPath,
    this.highlightedFullPathAndFileName,
  });

  /// get result items using [RequestFlags]
  factory ResultItem.fromRequestFlags(Everything e, RequestFlags flags, int index) {
    final kind = _resolveKind(e, flags, index);

    return ResultItem._(
      isVolumn: kind.isVolumn,
      isFolder: kind.isFolder,
      isFile: kind.isFile,
      filename: flags.fileName ? e.getResultFileName(index) : null,
      path: flags.path ? e.getResultPath(index) : null,
      fullPathName: flags.fullPathAndFileName
          ? e.getResultFullPathName(index)
          : null,
      extension: flags.extension ? e.getResultExtension(index) : null,
      size: flags.size ? e.getResultSize(index) : null,
      dateCreated: flags.dateCreated ? e.getResultDateCreated(index) : null,
      dateModified: flags.dateModified ? e.getResultDateModified(index) : null,
      dateAccessed: flags.dateAccessed ? e.getResultDateAccessed(index) : null,
      attributes: flags.attributes ? e.getResultAttributes(index) : null,
      fileListFileName: flags.fileListFileName
          ? e.getResultFileListFileName(index)
          : null,
      runCount: flags.runCount ? e.getResultRunCount(index) : null,
      dateRun: flags.dateRun ? e.getResultDateRun(index) : null,
      dateRecentlyChanged: flags.dateRecentlyChanged
          ? e.getResultDateRecentlyChanged(index)
          : null,
      highlightedFileName: flags.highlightedFileName
          ? e.getResultHighlightedFileName(index)
          : null,
      highlightedPath: flags.highlightedPath
          ? e.getResultHighlightedPath(index)
          : null,
      highlightedFullPathAndFileName: flags.highlightedFullPathAndFileName
          ? e.getResultHighlightedFullPathAndFileName(index)
          : null,
    );
  }

  static ({bool? isVolumn, bool? isFolder, bool? isFile}) _resolveKind(
    Everything e,
    RequestFlags flags,
    int index,
  ) {
    if (!flags.kind) {
      return (isVolumn: null, isFolder: null, isFile: null);
    }

    final isFile = e.isFileResult(index);
    final isFolder = !isFile && e.isFolderResult(index);
    final isVolumn = !isFile && !isFolder && e.isVolumeResult(index);

    return (isVolumn: isVolumn, isFolder: isFolder, isFile: isFile);
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
    if (fileListFileName != null) {
      strbuf.write('fileListFileName: $fileListFileName, ');
    }
    if (runCount != null) strbuf.write('runCount: $runCount, ');
    if (dateRun != null) strbuf.write('dateRun: $dateRun, ');
    if (dateRecentlyChanged != null) {
      strbuf.write('dateRecentlyChanged: $dateRecentlyChanged, ');
    }
    if (highlightedFileName != null) {
      strbuf.write('highlightedFileName: $highlightedFileName, ');
    }
    if (highlightedPath != null) {
      strbuf.write('highlightedPath: $highlightedPath, ');
    }
    if (highlightedFullPathAndFileName != null) {
      strbuf.write(
        'highlightedFullPathAndFileName: $highlightedFullPathAndFileName, ',
      );
    }

    return strbuf.toString();
  }
}

/// store results
@immutable
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
  Results({
    required this.fileNum,
    required this.folderNum,
    required this.resultsNum,
    required this.totFileNum,
    required this.totFolderNum,
    required this.totResultsNum,
    required this.requestFlags,
    required this.sort,
    required List<ResultItem> items,
  }) : items = List.unmodifiable(items);
}
