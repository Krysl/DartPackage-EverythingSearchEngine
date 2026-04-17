## 0.3.0-beta.1
* switch native DLL integration to Dart native assets using hooks and code_assets
  * runtime loading no longer depends on manual path initialization or DLL copying
  * simplify the public entry point to direct construction with Everything()
* improve generated SDK documentation and hover information
  * add SDK help links on the Everything wrapper
  * let doc generation preserve deprecation metadata for legacy MSI helpers
* update example and README to match the new loading model

## 0.2.1
* using `dart format .` to format code

## 0.2.0
* add [example](example/lib/main.dart)
* change flutter asset to [Public assets](https://dart.dev/tools/pub/package-layout#public-assets), so the package can be used from the command line.
  * The disadvantage is that assets must be added to `pubspec.yaml` when using *flutter*
    * ```yaml
      flutter:
        assets:
          - packages/everything_search_engine/src/dll/Everything64.dll
      ```
* rename enum `EverythingError` to `EverythingErrorCode`
  * add `EverythingException`

## 0.1.0
* add some missing class
* fix some api's return type to make it more usable
* make `runQuery` function more powerful

## 0.0.3

* Update doc

## 0.0.2

* Update doc

## 0.0.1

* Basic query support
