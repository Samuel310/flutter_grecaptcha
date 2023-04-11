import 'flutter_grecaptcha_platform_interface.dart';

class FlutterGrecaptcha {
  /// Instantiate a client by using the [siteKey] that you created for your Android app.
  ///
  /// Note: You must initialize the reCAPTCHA Enterprise client only once during the lifetime of your app.
  Future<bool> initializeRecaptchaClient({required String siteKey}) {
    return FlutterGrecaptchaPlatform.instance.initializeRecaptchaClient(
      siteKey: siteKey,
    );
  }

  /// Call this method to protect a LOGIN action.
  Future<String> executeLoginAction() {
    return FlutterGrecaptchaPlatform.instance.executeLoginAction();
  }
}
