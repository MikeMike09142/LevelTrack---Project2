// Centralized ads configuration. Provide production AdMob unit IDs via
// --dart-define at build time so you don't hardcode secrets in source.
// Example:
// flutter build appbundle --release \
//   --dart-define=ADMOB_REWARDED_ANDROID=ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx \
//   --dart-define=ADMOB_REWARDED_IOS=ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx

class AdsConfig {
  // Raw env strings (const-friendly). Empty when not provided.
  static const String _androidEnv =
      String.fromEnvironment('ADMOB_REWARDED_ANDROID', defaultValue: '');
  static const String _iosEnv =
      String.fromEnvironment('ADMOB_REWARDED_IOS', defaultValue: '');

  // Nullable getters for ergonomic usage in runtime logic.
  static String? get rewardedAndroidId =>
      _androidEnv.isEmpty ? null : _androidEnv;
  static String? get rewardedIosId => _iosEnv.isEmpty ? null : _iosEnv;
}