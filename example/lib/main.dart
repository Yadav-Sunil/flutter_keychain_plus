import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keychain_plus/flutter_keychain_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String id = "";
  String value = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (Platform.isAndroid) Text('Android Device ID: $id'),
              Text('Getting Data : $value'),
              ElevatedButton(
                  onPressed: () async {
                    String? data = await FlutterKeychainPlus.get(key: "key");
                    setState(() {
                      value = data ?? "";
                    });
                  },
                  child: Text('Get')),
              ElevatedButton(
                  onPressed: () {
                    FlutterKeychainPlus.put(key: "key", value: "1234567890");
                  },
                  child: Text('Put')),
              ElevatedButton(
                  onPressed: () async {
                    await FlutterKeychainPlus.remove(key: "key");
                    setState(() {
                      value = "";
                    });
                  },
                  child: Text('Remove')),
              ElevatedButton(
                  onPressed: () async {
                    await FlutterKeychainPlus.clear();
                    setState(() {
                      value = "";
                    });
                  },
                  child: Text('Clear')),
              if (Platform.isAndroid)
                ElevatedButton(
                    onPressed: () async {
                      String? data = await FlutterKeychainPlus.getDeviceId();
                      setState(() {
                        id = data ?? "";
                      });
                    },
                    child: Text('getDeviceId')),
            ],
          ),
        ),
      ),
    );
  }
}
