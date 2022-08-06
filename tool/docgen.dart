import 'docgen/parser.dart';
import 'docgen/patch.dart';

void main(List<String> args) async {
  await loadConfig();
  final docsMap = await getDocsMap();
  await patchFile(docsMap);
}
