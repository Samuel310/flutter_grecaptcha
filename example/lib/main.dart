import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grecaptcha/flutter_grecaptcha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterGrecaptchaPlugin = FlutterGrecaptcha();

  @override
  void initState() {
    super.initState();
    _initializeRecaptcha();
  }

  Future<void> _initializeRecaptcha() async {
    try {
      bool res = await FlutterGrecaptcha().initializeRecaptchaClient(
        siteKey: "<your-site-key>",
      );
      log("_initializeRecaptcha status : $res");
    } catch (e) {
      log("Error in _initializeRecaptcha : ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  String token =
                      await _flutterGrecaptchaPlugin.executeLoginAction();
                  log("token : $token");
                } catch (e) {
                  log(e.toString());
                }
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
