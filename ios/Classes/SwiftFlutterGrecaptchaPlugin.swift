import Flutter
import UIKit
import RecaptchaEnterprise

@available(iOS 13.0.0, *)
public class SwiftFlutterGrecaptchaPlugin: NSObject, FlutterPlugin {
    
    private var recaptchaClient: RecaptchaClient?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        print("register : called");
        let channel = FlutterMethodChannel(name: "flutter_grecaptcha", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterGrecaptchaPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("handle : called");
        switch (call.method) {
        case "initializeRecaptchaClient":
            self.initializeRecaptchaClient(call, result: result);
            break;
        case "executeLoginAction":
            self.executeLoginAction(call, result: result);
            break;
        default:
            result("No implementation found for this method");
            break;
        }
    }
    
    func initializeRecaptchaClient(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        Task {
            guard let args = call.arguments as? [String: Any],
                  let siteKey = args["siteKey"] as? String else {
                result(FlutterError(code: "initializeRecaptchaClient error", message: "Invalid arguments, siteKey is required", details: nil))
                return
            }
            let (recaptchaClient, error) =  await Recaptcha.getClient(
                siteKey: siteKey)
            if let recaptchaClient = recaptchaClient {
                self.recaptchaClient = recaptchaClient
                result(true);
            }
            if let error = error {
                print("RecaptchaClient creation error: \(error.errorMessage ?? "NIL").")
                result(FlutterError(code: "initializeRecaptchaClient error", message: "\(error.errorMessage ?? "NIL")", details: nil))
            }
        }
    }
    
    func executeLoginAction(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        Task {
            guard let client = self.recaptchaClient else {
                print("Client not initialized correctly.")
                result(FlutterError(code: "executeLoginAction error", message: "Client not initialized correctly.", details: nil))
                return
            }
            let (token, error) = await client.execute(
                RecaptchaAction(action: .login))
            if let token = token {
                result(token);
            } else {
                result(FlutterError(code: "executeLoginAction error", message: "\(error?.errorMessage ?? "NIL")", details: nil))
            }
        }
    }
}
