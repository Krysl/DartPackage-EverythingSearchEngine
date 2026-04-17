// ignore_for_file: public_member_api_docs

/// sdk_20260228\ipc\everything_ipc.h:722-727
/// ```c
/// #define EVERYTHING_IPC_FILE_INFO_FILE_SIZE								1
/// #define EVERYTHING_IPC_FILE_INFO_FOLDER_SIZE							2
/// #define EVERYTHING_IPC_FILE_INFO_DATE_CREATED							3
/// #define EVERYTHING_IPC_FILE_INFO_DATE_MODIFIED							4
/// #define EVERYTHING_IPC_FILE_INFO_DATE_ACCESSED							5
/// #define EVERYTHING_IPC_FILE_INFO_ATTRIBUTES								6
/// ```
enum FileInfoIndexed {
  fileSize(1),
  folderSize(2),
  dateCreated(3),
  dateModified(4),
  dateAccessed(5),
  attributes(6);

  const FileInfoIndexed(this._val);
  final int _val;

  int get value => _val;
}
