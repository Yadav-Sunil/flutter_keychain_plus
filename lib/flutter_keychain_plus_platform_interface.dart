import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_keychain_plus_method_channel.dart';

abstract class FlutterKeychainPlusPlatform extends PlatformInterface {
  /// Constructs a FlutterKeychainPlusPlatform.
  FlutterKeychainPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterKeychainPlusPlatform _instance = MethodChannelFlutterKeychainPlus();

  /// The default instance of [FlutterKeychainPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterKeychainPlus].
  static FlutterKeychainPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterKeychainPlusPlatform] when
  /// they register themselves.
  static set instance(FlutterKeychainPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> get({required String key}) {
    throw UnimplementedError('get(key) has not been implemented.');
  }

  Future<void> put({required String key, required String value}) {
    throw UnimplementedError('put(key, value) has not been implemented.');
  }

  Future<void> remove({required String key}) {
    throw UnimplementedError('remove(key) has not been implemented.');
  }

  Future<void> clear() {
    throw UnimplementedError('clear() has not been implemented.');
  }

  Future<String?> getDeviceId() {
    throw UnimplementedError('getDeviceId() has not been implemented.');
  }
}
