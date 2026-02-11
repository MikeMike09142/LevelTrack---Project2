import 'package:shared_preferences/shared_preferences.dart';
import 'storage_stub.dart';

class SharedPreferencesStorage implements Storage {
  @override
  Future<String?> read({String key = 'levels_json'}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> write(String value, {String key = 'levels_json'}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}

Storage getStorage() => SharedPreferencesStorage();