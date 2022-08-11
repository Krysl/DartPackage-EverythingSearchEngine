import 'file_attribute_constants.dart';

/// https://docs.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants
class FileAttribute {
  /// C value
  int val;

  /// create FileAttribute using C value
  FileAttribute(this.val);

  /// A file or directory that is an archive file or directory. Applications typically use this attribute to mark files for backup or removal .
  bool get isFileAttributeArchive => (val & FILE_ATTRIBUTE_ARCHIVE) != 0;

  /// A file or directory that is compressed. For a file, all of the data in the file is compressed. For a directory, compression is the default for newly created files and subdirectories.
  bool get isFileAttributeCompressed => (val & FILE_ATTRIBUTE_COMPRESSED) != 0;

  /// This value is reserved for system use.
  bool get isFileAttributeDevice => (val & FILE_ATTRIBUTE_DEVICE) != 0;

  /// The handle that identifies a directory.
  bool get isFileAttributeDirectory => (val & FILE_ATTRIBUTE_DIRECTORY) != 0;

  /// A file or directory that is encrypted. For a file, all data streams in the file are encrypted. For a directory, encryption is the default for newly created files and subdirectories.
  bool get isFileAttributeEncrypted => (val & FILE_ATTRIBUTE_ENCRYPTED) != 0;

  /// The file or directory is hidden. It is not included in an ordinary directory listing.
  bool get isFileAttributeHidden => (val & FILE_ATTRIBUTE_HIDDEN) != 0;

  /// Windows Server 2008 R2, Windows 7, Windows Server 2008, Windows Vista, Windows Server 2003 and Windows XP: This flag is not supported until Windows Server 2012.
  bool get isFileAttributeIntegrityStream =>
      (val & FILE_ATTRIBUTE_INTEGRITY_STREAM) != 0;

  /// A file that does not have other attributes set. This attribute is valid only when used alone.
  bool get isFileAttributeNormal => (val & FILE_ATTRIBUTE_NORMAL) != 0;

  /// The file or directory is not to be indexed by the content indexing service.
  bool get isFileAttributeNotContentIndexed =>
      (val & FILE_ATTRIBUTE_NOT_CONTENT_INDEXED) != 0;

  /// Windows Server 2008 R2, Windows 7, Windows Server 2008, Windows Vista, Windows Server 2003 and Windows XP: This flag is not supported until Windows 8 and Windows Server 2012.
  bool get isFileAttributeNoScrubData =>
      (val & FILE_ATTRIBUTE_NO_SCRUB_DATA) != 0;

  /// The data of a file is not available immediately. This attribute indicates that the file data is physically moved to offline storage. This attribute is used by Remote Storage, which is the hierarchical storage management software. Applications should not arbitrarily change this attribute.
  bool get isFileAttributeOffline => (val & FILE_ATTRIBUTE_OFFLINE) != 0;

  /// A file that is read-only. Applications can read the file, but cannot write to it or delete it. This attribute is not honored on directories. For more information, see You cannot view or change the Read-only or the System attributes of folders in Windows Server 2003, in Windows XP, in Windows Vista or in Windows 7.
  bool get isFileAttributeReadonly => (val & FILE_ATTRIBUTE_READONLY) != 0;

  /// When this attribute is set, it means that the file or directory is not fully present locally. For a file that means that not all of its data is on local storage (e.g. it may be sparse with some data still in remote storage). For a directory it means that some of the directory contents are being virtualized from another location. Reading the file / enumerating the directory will be more expensive than normal, e.g. it will cause at least some of the file/directory content to be fetched from a remote store. Only kernel-mode callers can set this bit.
  bool get isFileAttributeRecallOnDataAccess =>
      (val & FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS) != 0;

  /// This attribute only appears in directory enumeration classes (FILE_DIRECTORY_INFORMATION, FILE_BOTH_DIR_INFORMATION, etc.). When this attribute is set, it means that the file or directory has no physical representation on the local system; the item is virtual. Opening the item will be more expensive than normal, e.g. it will cause at least some of it to be fetched from a remote store.
  bool get isFileAttributeRecallOnOpen =>
      (val & FILE_ATTRIBUTE_RECALL_ON_OPEN) != 0;

  /// A file or directory that has an associated reparse point, or a file that is a symbolic link.
  bool get isFileAttributeReparsePoint =>
      (val & FILE_ATTRIBUTE_REPARSE_POINT) != 0;

  /// A file that is a sparse file.
  bool get isFileAttributeSparseFile => (val & FILE_ATTRIBUTE_SPARSE_FILE) != 0;

  /// A file or directory that the operating system uses a part of, or uses exclusively.
  bool get isFileAttributeSystem => (val & FILE_ATTRIBUTE_SYSTEM) != 0;

  /// A file that is being used for temporary storage. File systems avoid writing data back to mass storage if sufficient cache memory is available, because typically, an application deletes a temporary file after the handle is closed. In that scenario, the system can entirely avoid writing the data. Otherwise, the data is written after the handle is closed.
  bool get isFileAttributeTemporary => (val & FILE_ATTRIBUTE_TEMPORARY) != 0;

  /// This value is reserved for system use.
  bool get isFileAttributeVirtual => (val & FILE_ATTRIBUTE_VIRTUAL) != 0;

  /// This attribute indicates user intent that the file or directory should be kept fully present locally even when not being actively accessed. This attribute is for use with hierarchical storage management software.
  bool get isFileAttributePinned => (val & FILE_ATTRIBUTE_PINNED) != 0;

  /// This attribute indicates that the file or directory should not be kept fully present locally except when being actively accessed. This attribute is for use with hierarchical storage management software.
  bool get isFileAttributeUnpinned => (val & FILE_ATTRIBUTE_UNPINNED) != 0;
}
