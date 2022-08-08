import 'everything.g.dart';

/// Target Machine type
enum EverythingTargetMachine {
  /// Target machine is x86 (32 bit).
  x86(EVERYTHING_TARGET_MACHINE_X86),

  /// Target machine is x64 (64 bit).
  x64(EVERYTHING_TARGET_MACHINE_X64),

  /// Target machine is ARM.
  arm(EVERYTHING_TARGET_MACHINE_ARM),

  /// target machine information is unavailable.
  unavailable(0);

  /// the value defined in C code
  final int val;

  ///
  const EverythingTargetMachine(this.val);

  /// trans C value to Dart enum
  factory EverythingTargetMachine.fromVal(int val) {
    switch (val) {
      case EVERYTHING_TARGET_MACHINE_X86:
        return x86;
      case EVERYTHING_TARGET_MACHINE_X64:
        return x64;
      case EVERYTHING_TARGET_MACHINE_ARM:
        return arm;
      default:
        return unavailable;
    }
  }
}
