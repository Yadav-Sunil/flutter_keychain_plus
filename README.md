# flutter_keychain_plus

This Plugin Updated Version of [flutter_keychain](https://pub.dev/packages/flutter_keychain)

A Flutter plugin for supporting secure storage of strings via Keychain and Keystore

If you have other types you want to store, you need to serialize to and from UTF-8 strings.

* [Keychain](https://developer.apple.com/library/content/documentation/Security/Conceptual/keychainServConcepts/01introduction/introduction.html#//apple_ref/doc/uid/TP30000897-CH203-TP1) is used for iOS
* AES encryption is used for Android. AES secret key is encrypted with RSA and RSA key is stored in [KeyStore](https://developer.android.com/training/articles/keystore.html)

*Note* KeyStore was introduced in Android 4.3 (API level 18). The plugin does not work on earlier versions.


## Getting Started
```dart

import 'package:flutter_keychain_plus/flutter_keychain_plus.dart';
...

// Get value
var value = await FlutterKeychainPlus.get(key: "key");

// Put value
await FlutterKeychainPlus.put(key: "key", value: "value");

// Remove item
await FlutterKeychainPlus.remove(key: "key");

// Clear the secure store
await FlutterKeychainPlus.clear();

```

### Configure Android version
In `[project]/android/app/build.gradle` set `minSdkVersion` to >= 18.
```
android {
    ...
    defaultConfig {
        ...
        minSdkVersion 18
        ...
    }
}
```

## Contributing

For help on editing plugin code, view the [documentation](https://flutter.io/developing-packages/#edit-plugin-package).