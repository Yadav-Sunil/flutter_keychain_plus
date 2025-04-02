import 'flutter_keychain_plus_platform_interface.dart';

class FlutterKeychainPlus {
  static Future<String?> get({required String key}) {
    return FlutterKeychainPlusPlatform.instance.get(key: key);
  }

  static Future<void> put({required String key, required String value}) {
    return FlutterKeychainPlusPlatform.instance.put(key: key, value: value);
  }

  static Future<void> remove({required String key}) {
    return FlutterKeychainPlusPlatform.instance.remove(key: key);
  }

  static Future<void> clear() {
    return FlutterKeychainPlusPlatform.instance.clear();
  }

  static Future<String?> getDeviceId() {
    return FlutterKeychainPlusPlatform.instance.getDeviceId();
  }
}
