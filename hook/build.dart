import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) {
      return;
    }

    if (input.config.code.targetOS != OS.windows) {
      return;
    }

    final architecture = input.config.code.targetArchitecture
        .toString()
        .toLowerCase();
    final dllFileName = switch (architecture) {
      final value when value.contains('arm64') => 'EverythingARM64.dll',
      final value when value.contains('arm') => 'EverythingARM.dll',
      final value when value.contains('x64') || value.contains('64') =>
        'Everything64.dll',
      _ => 'Everything32.dll',
    };

    final dllUri = input.packageRoot.resolve('thirdparty/dll/$dllFileName');
    final dllFile = File.fromUri(dllUri);
    if (!dllFile.existsSync()) {
      throw StateError('Missing native library: ${dllFile.path}');
    }

    output.assets.code.add(
      CodeAsset(
        package: input.packageName,
        name: 'src/ffi/everything.g.dart',
        file: dllFile.absolute.uri,
        linkMode: DynamicLoadingBundled(),
      ),
    );
  });
}
