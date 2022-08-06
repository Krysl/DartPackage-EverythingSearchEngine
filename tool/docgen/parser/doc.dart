class Doc {
  String? h1;
  List<String> description = [];
  List<String> syntax = [];
  List<String> parameters = [];
  List<String> returnValue = [];
  List<String> remarks = [];
  List<String> example = [];
  List<String> functionInformation = [];
  List<String> seeAlso = [];

  @override
  String toString() {
    final strbuf = StringBuffer();
    strbuf.write('  /// ');
    if (description.isNotEmpty) strbuf.writeln(description.join('\n'));
    if (syntax.isNotEmpty) {
      strbuf.writeln('## Syntax');
      strbuf.writeln(syntax.join('\n'));
    }
    if (parameters.isNotEmpty) {
      strbuf.writeln('## Parameters');
      strbuf.writeln(parameters.join('\n'));
    }
    if (returnValue.isNotEmpty) {
      strbuf.writeln('## Return Value');
      strbuf.writeln(returnValue.join('\n'));
    }
    if (remarks.isNotEmpty) {
      strbuf.writeln('## Remarks');
      strbuf.writeln(remarks.join('\n'));
    }
    if (example.isNotEmpty) {
      strbuf.writeln('## Example');
      strbuf.writeln(example.join('\n'));
    }
    if (functionInformation.isNotEmpty) {
      strbuf.writeln('## Function Information');
      strbuf.writeln(functionInformation.join('\n'));
    }
    if (seeAlso.isNotEmpty) {
      strbuf.writeln('## See Also');
      strbuf.writeln(seeAlso.join('\n'));
    }
    return strbuf.toString().trimRight().split('\n').join('  \n  /// ');
  }
}
