import 'dart:html' as html;
import 'storage_stub.dart';

class WebStorage implements Storage {
  @override
  Future<String?> read({String key = 'levels_json'}) async => html.window.localStorage[key];

  @override
  Future<void> write(String value, {String key = 'levels_json'}) async {
    html.window.localStorage[key] = value;
  }
}

Storage getStorage() => WebStorage();