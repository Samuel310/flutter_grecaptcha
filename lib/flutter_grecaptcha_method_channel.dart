import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_grecaptcha_platform_interface.dart';

/// An implementation of [FlutterGrecaptchaPlatform] that uses method channels.
class MethodChannelFlutterGrecaptcha extends FlutterGrecaptchaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_grecaptcha');

  @override
  Future<bool> initializeRecaptchaClient({required String siteKey}) async {
    try {
      bool? res = await methodChannel.invokeMethod<bool>(
          'initializeRecaptchaClient', {"siteKey": siteKey});
      return res ?? false;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> executeLoginAction() async {
    try {
      String? res =
          await methodChannel.invokeMethod<String>('executeLoginAction');
      if (res == null) throw "Token is empty";
      return res;
    } catch (e) {
      return Future.error(e);
    }
  }
}
