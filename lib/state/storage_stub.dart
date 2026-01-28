abstract class Storage {
  Future<String?> read({String key = 'levels_json'});
  Future<void> write(String value, {String key = 'levels_json'});
}

Storage getStorage() => throw UnimplementedError('No storage implementation for this platform');