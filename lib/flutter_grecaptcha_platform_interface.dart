import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_grecaptcha_method_channel.dart';

abstract class FlutterGrecaptchaPlatform extends PlatformInterface {
  /// Constructs a FlutterGrecaptchaPlatform.
  FlutterGrecaptchaPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterGrecaptchaPlatform _instance = MethodChannelFlutterGrecaptcha();

  /// The default instance of [FlutterGrecaptchaPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterGrecaptcha].
  static FlutterGrecaptchaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterGrecaptchaPlatform] when
  /// they register themselves.
  static set instance(FlutterGrecaptchaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Instantiate a client by using the [siteKey] that you created for your Android app.
  ///
  /// Note: You must initialize the reCAPTCHA Enterprise client only once during the lifetime of your app.
  Future<bool> initializeRecaptchaClient({required String siteKey}) {
    throw UnimplementedError(
        'initializeRecaptchaClient() has not been implemented.');
  }

  /// Call this method to protect a LOGIN action.
  Future<String> executeLoginAction() {
    throw UnimplementedError('executeLoginAction() has not been implemented.');
  }
}
