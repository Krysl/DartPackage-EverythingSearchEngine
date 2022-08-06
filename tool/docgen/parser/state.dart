enum ParseState {
  start,
  h1,
  description,
  h2,
  syntax,
  parameters,
  returnValue,
  remarks,
  example,
  seeAlso,
  end;

  ParseState next() => ParseState.values.firstWhere(
        (e) => e.index > index,
        orElse: () => end,
      );
}
