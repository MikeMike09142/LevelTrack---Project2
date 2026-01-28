import 'dart:io';
import 'storage_stub.dart';

class FileStorage implements Storage {
  final Map<String, File> _files = {
    'levels_json': File('lib/data/levels.json'),
    'app_settings': File('lib/data/app_settings.json'),
  };

  @override
  Future<String?> read({String key = 'levels_json'}) async {
    final file = _files[key];
    if (file == null) return null;
    try {
      if (await file.exists()) {
        return await file.readAsString();
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<void> write(String value, {String key = 'levels_json'}) async {
    final file = _files[key];
    if (file == null) return;
    try {
      await file.create(recursive: true);
      await file.writeAsString(value);
    } catch (_) {}
  }
}

Storage getStorage() => FileStorage();