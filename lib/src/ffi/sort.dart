import 'everything.g.dart';

/// sort mode for query results
enum EverythingSort implements Comparable<EverythingSort> {
  /// sort by name ascending
  nameAscending(EVERYTHING_SORT_NAME_ASCENDING),

  /// sort by name descending
  nameDescending(EVERYTHING_SORT_NAME_DESCENDING),

  /// sort by path ascending
  pathAscending(EVERYTHING_SORT_PATH_ASCENDING),

  /// sort by path descending
  pathDescending(EVERYTHING_SORT_PATH_DESCENDING),

  /// sort by size ascending
  sizeAscending(EVERYTHING_SORT_SIZE_ASCENDING),

  /// sort by size descending
  sizeDescending(EVERYTHING_SORT_SIZE_DESCENDING),

  /// sort by extension ascending
  extensionAscending(EVERYTHING_SORT_EXTENSION_ASCENDING),

  /// sort by extension descending
  extensionDescending(EVERYTHING_SORT_EXTENSION_DESCENDING),

  /// sort by type name ascending
  typeNameAscending(EVERYTHING_SORT_TYPE_NAME_ASCENDING),

  /// sort by type name descending
  typeNameDescending(EVERYTHING_SORT_TYPE_NAME_DESCENDING),

  /// sort by date created ascending
  dateCreatedAscending(EVERYTHING_SORT_DATE_CREATED_ASCENDING),

  /// sort by date created descending
  dateCreatedDescending(EVERYTHING_SORT_DATE_CREATED_DESCENDING),

  /// sort by date modified ascending
  dateModifiedAscending(EVERYTHING_SORT_DATE_MODIFIED_ASCENDING),

  /// sort by date modified descending
  dateModifiedDescending(EVERYTHING_SORT_DATE_MODIFIED_DESCENDING),

  /// sort by attributes ascending
  attributesAscending(EVERYTHING_SORT_ATTRIBUTES_ASCENDING),

  /// sort by attributes descending
  attributesDescending(EVERYTHING_SORT_ATTRIBUTES_DESCENDING),

  /// sort by file list filename ascending
  fileListFilenameAscending(EVERYTHING_SORT_FILE_LIST_FILENAME_ASCENDING),

  /// sort by file list filename descending
  fileListFilenameDescending(EVERYTHING_SORT_FILE_LIST_FILENAME_DESCENDING),

  /// sort by run count ascending
  runCountAscending(EVERYTHING_SORT_RUN_COUNT_ASCENDING),

  /// sort by run count descending
  runCountDescending(EVERYTHING_SORT_RUN_COUNT_DESCENDING),

  /// sort by date recently changed ascending
  dateRecentlyChangedAscending(EVERYTHING_SORT_DATE_RECENTLY_CHANGED_ASCENDING),

  /// sort by date recently changed descending
  dateRecentlyChangedDescending(
      EVERYTHING_SORT_DATE_RECENTLY_CHANGED_DESCENDING),

  /// sort by date accessed ascending
  dateAccessedAscending(EVERYTHING_SORT_DATE_ACCESSED_ASCENDING),

  /// sort by date accessed descending
  dateAccessedDescending(EVERYTHING_SORT_DATE_ACCESSED_DESCENDING),

  /// sort by date run ascending
  dateRunAscending(EVERYTHING_SORT_DATE_RUN_ASCENDING),

  /// sort by date run descending
  dateRunDescending(EVERYTHING_SORT_DATE_RUN_DESCENDING),

  ///
  unknow(-1);

  /// the value defined in C code
  final int val;

  ///
  const EverythingSort(this.val);

  /// trans C value to Dart enum
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
