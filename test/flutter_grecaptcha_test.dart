import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_grecaptcha/flutter_grecaptcha.dart';
import 'package:flutter_grecaptcha/flutter_grecaptcha_platform_interface.dart';
import 'package:flutter_grecaptcha/flutter_grecaptcha_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterGrecaptchaPlatform
    with MockPlatformInterfaceMixin
    implements FlutterGrecaptchaPlatform {
  @override
  Future<String> executeLoginAction() => Future.value('some-token');

  @override
  Future<bool> initializeRecaptchaClient({required String siteKey}) =>
      Future.value(true);
}

void main() {
  final FlutterGrecaptchaPlatform initialPlatform =
      FlutterGrecaptchaPlatform.instance;

  test('$MethodChannelFlutterGrecaptcha is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterGrecaptcha>());
  });

  test('getPlatformVersion', () async {
    FlutterGrecaptcha flutterGrecaptchaPlugin = FlutterGrecaptcha();
    MockFlutterGrecaptchaPlatform fakePlatform =
        MockFlutterGrecaptchaPlatform();
    FlutterGrecaptchaPlatform.instance = fakePlatform;

    expect(
        await flutterGrecaptchaPlugin.initializeRecaptchaClient(
            siteKey: "siteKey"),
        true);
  });
}
