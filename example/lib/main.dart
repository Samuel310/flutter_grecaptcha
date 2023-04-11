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
    _flutterGrecaptchaPlugin.initializeRecaptchaClient(siteKey: "siteKey");
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
                await _flutterGrecaptchaPlugin.executeLoginAction();
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
