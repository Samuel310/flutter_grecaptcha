import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_grecaptcha/flutter_grecaptcha_method_channel.dart';

void main() {
  MethodChannelFlutterGrecaptcha platform = MethodChannelFlutterGrecaptcha();
  const MethodChannel channel = MethodChannel('flutter_grecaptcha');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.initializeRecaptchaClient(siteKey: "siteKey"), true);
  });
}
