#import "FlutterGrecaptchaPlugin.h"
#import <RecaptchaEnterprise/RecaptchaEnterprise.h>
#if __has_include(<flutter_grecaptcha/flutter_grecaptcha-Swift.h>)
#import <flutter_grecaptcha/flutter_grecaptcha-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_grecaptcha-Swift.h"
#endif

@implementation FlutterGrecaptchaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterGrecaptchaPlugin registerWithRegistrar:registrar];
}
@end
