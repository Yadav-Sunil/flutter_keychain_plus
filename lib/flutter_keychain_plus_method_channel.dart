import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_keychain_plus_platform_interface.dart';

/// An implementation of [FlutterKeychainPlusPlatform] that uses method channels.
class MethodChannelFlutterKeychainPlus extends FlutterKeychainPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_keychain_plus');

  // get - get the value for a given key
  @override
  Future<String?> get({required String key}) async => await methodChannel.invokeMethod('get', {'key': key});

  // put - store the value for a key
  @override
  Future<void> put({required String key, required String value}) async =>
      methodChannel.invokeMethod('put', {'key': key, 'value': value});

  // remove - remove entry for a given key
  @override
  Future<void> remove({required String key}) async =>
      await methodChannel.invokeMethod('remove', {'key': key});

  // clear - clear the keychain
  @override
  Future<void> clear() async => await methodChannel.invokeMethod('clear');

  // getDeviceId - get Android hardware ID
  @override
  Future<String?> getDeviceId() async => await methodChannel.invokeMethod('getDeviceId');
}
