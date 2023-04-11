import 'flutter_grecaptcha_platform_interface.dart';

class FlutterGrecaptcha {
  Future<bool> initializeRecaptchaClient({required String siteKey}) {
    return FlutterGrecaptchaPlatform.instance.initializeRecaptchaClient(
      siteKey: siteKey,
    );
  }

  Future<String> executeLoginAction() {
    return FlutterGrecaptchaPlatform.instance.executeLoginAction();
  }
}
