import 'package:flutter/services.dart';
import 'package:flutter_keychain_plus/flutter_keychain_plus_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterKeychainPlus platform = MethodChannelFlutterKeychainPlus();
  const MethodChannel channel = MethodChannel('flutter_keychain_plus');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('get', () async {
    expect(await platform.get(key: "key"), '42');
  });

  test('put', () async {
    await platform.put(key: "key", value: "123456");
  });

  test('remove', () async {
    await platform.remove(key: "key");
  });

  test('clear', () async {
    await platform.clear();
  });
}
