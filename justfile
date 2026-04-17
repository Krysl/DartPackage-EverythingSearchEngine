default:
  @just --choose

about:
    @awk '/^#/ {print} !/^#/ {exit}' "{{justfile()}}"
    @echo 'Summarises the purpose of this file.'
    @echo 'This lists the comment lines of the file until the first line that does not start with a '#' character. Then it lists the targets of the file.'
    @just --list

alias f := ffigen
alias br := build_runner
alias ig := index_generator

ffigen:
  dart run ffigen --config ffigen.yaml --verbose all > ffigen.log

build_runner:
  dart run build_runner build

index_generator:
  @echo See More: https://pub.dev/packages/index_generator
  dart pub global run index_generator -s index_generator.yaml 

docgen:
  dart tool/docgen.dart

doc:
  dart doc . > doc.log 2>&1
