import 'package:web/web.dart' as web;
import 'storage_stub.dart';

class WebStorage implements Storage {
  @override
  Future<String?> read({String key = 'levels_json'}) async => web.window.localStorage.getItem(key);

  @override
  Future<void> write(String value, {String key = 'levels_json'}) async {
    web.window.localStorage.setItem(key, value);
  }
}

Storage getStorage() => WebStorage();