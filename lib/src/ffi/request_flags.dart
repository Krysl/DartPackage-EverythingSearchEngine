import 'everything.g.dart';

/// config to select what to show in results
class RequestFlags {
  /// request 'File name' in results
  final bool fileName;

  /// request 'Path' in results
  final bool path;

  /// request 'Full path and file name' in results
  final bool fullPathAndFileName;

  /// request 'Extension' in results
  final bool extension;

  /// request 'Size' in results
  final bool size;

  /// request 'Date created' in results
  final bool dateCreated;

  /// request 'Date modified' in results
  final bool dateModified;

  /// request 'Date accessed' in results
  final bool dateAccessed;

  /// request 'Attributes' in results
  final bool attributes;

  /// request 'File list file name' in results
  final bool fileListFileName;

  /// request 'Run count' in results
  final bool runCount;

  /// request 'Date run' in results
  final bool dateRun;

  /// request 'Date recently changed' in results
  final bool dateRecentlyChanged;

  /// request 'Highlighted file name' in results
  final bool highlightedFileName;

  /// request 'Highlighted path' in results
  final bool highlightedPath;

  /// request 'Highlighted full path and file name' in results
  final bool highlightedFullPathAndFileName;

  /// Creates a new default allocator that applies no prefixing.
  RequestFlags({
    this.fileName = true,
    this.path = true,
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

  /// construct dart [RequestFlags] class from C int flags
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

  /// the value defined in C code
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
