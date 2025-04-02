import 'package:flutter_keychain_plus/flutter_keychain_plus.dart';
import 'package:flutter_keychain_plus/flutter_keychain_plus_method_channel.dart';
import 'package:flutter_keychain_plus/flutter_keychain_plus_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterKeychainPlusPlatform with MockPlatformInterfaceMixin implements FlutterKeychainPlusPlatform {
  @override
  Future<void> clear() {
    return Future.value();
  }

  @override
  Future<String?> get({required String key}) {
    return Future.value('deviceKey');
  }

  @override
  Future<void> put({required String key, required String value}) {
    return Future.value();
  }

  @override
  Future<void> remove({required String key}) {
    return Future.value();
  }

  @override
  Future<String?> getDeviceId() {
    return Future.value('deviceID');
  }
}

void main() {
  final FlutterKeychainPlusPlatform initialPlatform = FlutterKeychainPlusPlatform.instance;

  test('$MethodChannelFlutterKeychainPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterKeychainPlus>());
  });

  test('get', () async {
    MockFlutterKeychainPlusPlatform fakePlatform = MockFlutterKeychainPlusPlatform();
    FlutterKeychainPlusPlatform.instance = fakePlatform;

    expect(await FlutterKeychainPlus.get(key: 'key'), '42');
  });

  test('put', () async {
    MockFlutterKeychainPlusPlatform fakePlatform = MockFlutterKeychainPlusPlatform();
    FlutterKeychainPlusPlatform.instance = fakePlatform;

    await FlutterKeychainPlus.put(key: 'key', value: '123456');
  });

  test('remove', () async {
    MockFlutterKeychainPlusPlatform fakePlatform = MockFlutterKeychainPlusPlatform();
    FlutterKeychainPlusPlatform.instance = fakePlatform;

    await FlutterKeychainPlus.remove(key: 'key');
  });

  test('clear', () async {
    MockFlutterKeychainPlusPlatform fakePlatform = MockFlutterKeychainPlusPlatform();
    FlutterKeychainPlusPlatform.instance = fakePlatform;

    await FlutterKeychainPlus.clear();
  });

  test('getDeviceId', () async {
    MockFlutterKeychainPlusPlatform fakePlatform = MockFlutterKeychainPlusPlatform();
    FlutterKeychainPlusPlatform.instance = fakePlatform;

    await FlutterKeychainPlus.getDeviceId();
  });
}
