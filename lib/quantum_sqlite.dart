import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';

final _Binding _binding = _Binding(open.openSqlite());

extension Sqlite3FtsExtension on Database {
  void loadExtesnion(String zFile) {
    // FIXME https://www.sqlite.org/c3ref/enable_load_extension.html
    _binding.sqlite3EnableLoadExtension(handle.cast(), 1);

    final errorOut = malloc<Pointer<Utf8>>();
    final ret = _binding.sqlite3LoadExtension(
        handle.cast(), zFile.toNativeUtf8(), nullptr, errorOut);
    try {
      if (ret != 0) {
        throw Exception(
            'Error loading extension($ret): ${errorOut.value.toDartString()}');
      }
    } finally {
      malloc.free(errorOut);
    }

    _binding.sqlite3EnableLoadExtension(handle.cast(), 0);
  }

  void loadSimpleExtension() {
    final dir = dirname(Platform.resolvedExecutable);

    String simpleLibPath = "";
    String dictPath;
    if (Platform.isWindows) {
      simpleLibPath = join(dir, 'simple.dll');
      // data\flutter_assets\packages\quantum\dicts
      dictPath = join(
          dir, 'data', 'flutter_assets', 'packages', 'quantum', 'dicts');
    } else if (Platform.isMacOS) {
      simpleLibPath = 'libsimple';
      // ../Frameworks/App.framework/Resources/flutter_assets/packages/quantum/dicts
      dictPath = join(dir, '..', 'Frameworks', 'App.framework', 'Resources',
          'flutter_assets', 'packages', 'quantum_sqlite');
      dictPath = join(dictPath, 'resources', 'jieba', 'dicts');
    } else if (Platform.isLinux) {
      simpleLibPath = join(dir, 'lib', 'libsimple.so');
      // data/flutter_assets/packages/quantum/dicts
      dictPath = join(
          dir, 'data', 'flutter_assets', 'packages', 'quantum', 'dicts');
    } else if (Platform.isIOS) {
      dictPath = join(dir, 'Frameworks', 'App.framework',
          'flutter_assets', 'packages', 'quantum_sqlite', 'resources', 'jieba');
      dictPath = join(dictPath, 'dicts');
      //return;
    } else {
      assert(false, 'Unsupported platform');
      return;
    }

    debugPrint('simpleLibPath: $simpleLibPath');
    debugPrint('dictPath: $dictPath');

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      try {
        loadExtesnion(simpleLibPath);
      } catch (e, s) {
        debugPrint('Error loading simple extension: $e $s');
        return;
      }
    }
    final exist = Directory(dictPath).existsSync();
    assert(exist, 'dictPath($dictPath) does not exist');
    if (!exist) {
      return;
    }
    select('select jieba_dict(?)', [dictPath]);
  }
}

typedef _Sqlite3LoadExtensionNative = Int32 Function(Pointer<Void> db,
    Pointer<Utf8> zFile, Pointer<Utf8> zProc, Pointer<Pointer<Utf8>> pzErrMsg);
typedef _Sqlite3LoadExtensionDart = int Function(Pointer<Void> db,
    Pointer<Utf8> zFile, Pointer<Utf8> zProc, Pointer<Pointer<Utf8>> pzErrMsg);

typedef _Sqlite3EnableLoadExtensionNative = Int32 Function(
    Pointer<Void> db, Int32 onoff);
typedef _Sqlite3EnableLoadExtensionDart = int Function(
    Pointer<Void> db, int onoff);

class _Binding {
  _Binding(this.library)
      : sqlite3LoadExtension = library.lookupFunction<
      _Sqlite3LoadExtensionNative,
      _Sqlite3LoadExtensionDart>("sqlite3_load_extension"),
        sqlite3EnableLoadExtension = library.lookupFunction<
            _Sqlite3EnableLoadExtensionNative,
            _Sqlite3EnableLoadExtensionDart>(
            "sqlite3_enable_load_extension");

  final DynamicLibrary library;

  final _Sqlite3LoadExtensionDart sqlite3LoadExtension;
  final _Sqlite3EnableLoadExtensionDart sqlite3EnableLoadExtension;
}


class Quantum {
  static const MethodChannel _channel = MethodChannel('quantum');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
