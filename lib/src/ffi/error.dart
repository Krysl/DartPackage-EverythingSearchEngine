import 'everything.g.dart';

/// error code retrieved by [Everything.lastError]
/// https://www.voidtools.com/support/everything/sdk/everything_getlasterror/#return_value
enum EverythingError implements Comparable<EverythingError> {
  /// The operation completed successfully.
  ok(EVERYTHING_OK),

  ///Failed to allocate memory for the search query.
  errorMemory(EVERYTHING_ERROR_MEMORY),

  /// IPC is not available.
  errorIpc(EVERYTHING_ERROR_IPC),

  /// Failed to register the search query window class.
  errorRegisterClassEx(EVERYTHING_ERROR_REGISTERCLASSEX),

  /// Failed to create the search query window.
  errorCreateWindow(EVERYTHING_ERROR_CREATEWINDOW),

  /// Failed to create the search query thread.
  errorCreateThread(EVERYTHING_ERROR_CREATETHREAD),

  /// Invalid index. The index must be greater or equal to 0
  ///  and less than the number of visible results.
  errorInvalidIndex(EVERYTHING_ERROR_INVALIDINDEX),

  /// Invalid call. Call [Everything_Query] before calling Everything_GetResultSize.
  errorInvalidCall(EVERYTHING_ERROR_INVALIDCALL),

  /// Size was not requested or is unavailable, set [Everything.requestFlags] with [RequestFlags.size] before calling [Everything.query].
  errorInvalidRequest(EVERYTHING_ERROR_INVALIDREQUEST),

  ///
  errorInvalidParameter(EVERYTHING_ERROR_INVALIDPARAMETER),

  ///
  errorUnknow(-1);

  /// the value defined in C code
  final int val;

  /// enum constructor
  const EverythingError(this.val);

  /// trans C value to Dart enum
  factory EverythingError.fromVal(int val) {
    switch (val) {
      case EVERYTHING_OK:
        return ok;
      case EVERYTHING_ERROR_MEMORY:
        return errorMemory;
      case EVERYTHING_ERROR_IPC:
        return errorIpc;
      case EVERYTHING_ERROR_REGISTERCLASSEX:
        return errorRegisterClassEx;
      case EVERYTHING_ERROR_CREATEWINDOW:
        return errorCreateWindow;
      case EVERYTHING_ERROR_CREATETHREAD:
        return errorCreateThread;
      case EVERYTHING_ERROR_INVALIDINDEX:
        return errorInvalidIndex;
      case EVERYTHING_ERROR_INVALIDCALL:
        return errorInvalidCall;
      case EVERYTHING_ERROR_INVALIDREQUEST:
        return errorInvalidRequest;
      case EVERYTHING_ERROR_INVALIDPARAMETER:
        return errorInvalidParameter;
      default:
        return errorUnknow;
    }
  }
  @override
  int compareTo(EverythingError other) => val - other.val;
}
