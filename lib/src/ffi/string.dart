import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'everything.g.dart';

extension ToDartString on LPCWSTR {
  int get length {
    _ensureNotNullptr('length');
    final codeUnits = cast<ffi.Uint16>();
    return _length(codeUnits);
  }

  String toDartString({int? length}) {
    try {
      _ensureNotNullptr('toDartString');
    } on UnsupportedError catch (e) {
      return 'null';
    }
    final codeUnits = cast<ffi.Uint16>();
    if (length == null) {
      return _toUnknownLengthString(codeUnits);
    } else {
      RangeError.checkNotNegative(length, 'length');
      return _toKnownLengthString(codeUnits, length);
    }
  }

  static String _toKnownLengthString(ffi.Pointer<ffi.Uint16> codeUnits, int length) =>
      String.fromCharCodes(codeUnits.asTypedList(length));

  static String _toUnknownLengthString(ffi.Pointer<ffi.Uint16> codeUnits) {
    final buffer = StringBuffer();
    var i = 0;
    while (true) {
      final char = codeUnits.elementAt(i).value;
      if (char == 0) {
        return buffer.toString();
      }
      buffer.writeCharCode(char);
      i++;
    }
  }

  static int _length(ffi.Pointer<ffi.Uint16> codeUnits) {
    var length = 0;
    while (codeUnits[length] != 0) {
      length++;
    }
    return length;
  }

  void _ensureNotNullptr(String operation) {
    if (this == ffi.nullptr) {
      throw UnsupportedError("Operation '$operation' not allowed on a 'nullptr'.");
    }
  }
}

extension StringToLPCWSTR on String {
  LPCWSTR toLPCWSTR({ffi.Allocator allocator = malloc}) {
    final units = codeUnits;
    final LPCWSTR result = allocator<WCHAR>(units.length + 1);
    final ptr = result.cast<ffi.Uint16>();
    final Uint16List nativeString = ptr.asTypedList(units.length + 1);
    nativeString.setRange(0, units.length, units);
    nativeString[units.length] = 0;
    return result.cast();
  }
}
