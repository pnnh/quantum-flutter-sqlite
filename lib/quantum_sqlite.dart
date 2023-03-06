import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';

extension Sqlite3FtsExtension on Database {
  void loadSimpleExtension() {
    final dir = dirname(Platform.resolvedExecutable);

    String simpleLibPath = "";
    String dictPath;
    if (Platform.isIOS) {
      dictPath = join(dir, 'Frameworks', 'App.framework', 'flutter_assets',
          'packages', 'quantum_sqlite', 'resources', 'jieba');
      dictPath = join(dictPath, 'dicts');
    } else {
      assert(false, 'Unsupported platform');
      return;
    }

    debugPrint('simpleLibPath: $simpleLibPath');
    debugPrint('dictPath: $dictPath');

    final exist = Directory(dictPath).existsSync();
    assert(exist, 'dictPath($dictPath) does not exist');
    if (!exist) {
      return;
    }
    select('select jieba_dict(?)', [dictPath]);
  }
}

class Quantum {
  static const MethodChannel _channel = MethodChannel('quantum');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
