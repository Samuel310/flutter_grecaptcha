package com.samuel310.flutter_grecaptcha.flutter_grecaptcha;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.recaptcha.Recaptcha;
import com.google.android.recaptcha.RecaptchaAction;
import com.google.android.recaptcha.RecaptchaTasksClient;

import java.util.concurrent.Executor;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterGrecaptchaPlugin */
public class FlutterGrecaptchaPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Nullable
  private RecaptchaTasksClient recaptchaTasksClient = null;

  @Nullable
  private Activity activity = null;

  private static final String TAG = "FlutterGrecaptchaPlugin";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_grecaptcha");
    channel.setMethodCallHandler(this);

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "initializeRecaptchaClient":
        initializeRecaptchaClient(call, result);
        break;
      case "executeLoginAction":
        executeLoginAction(call, result);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
   activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }

  private void initializeRecaptchaClient(@NonNull MethodCall call, @NonNull Result result) {
    String key = call.argument("siteKey");
    assert key != null;
    assert activity != null;
    Recaptcha.getTasksClient(activity.getApplication(), key )
      .addOnSuccessListener(
              activity,
              new OnSuccessListener<RecaptchaTasksClient>() {
                @Override
                public void onSuccess(RecaptchaTasksClient client) {
                  recaptchaTasksClient = client;
                  Log.d(TAG, "onSuccess: initializeRecaptchaClient completed!");
                  result.success(true);
                }
              })
      .addOnFailureListener(
              activity,
              new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                  Log.d(TAG, "onFailure: initializeRecaptchaClient failed!");
                  Log.e(TAG, "onFailure: initializeRecaptchaClient failed!", e);
                  e.printStackTrace();
                  result.error("initializeRecaptchaClient error", "Failed to initialize recaptcha", e);

                }
              });
  }

  private void executeLoginAction(@NonNull MethodCall call, @NonNull Result result) {
    assert recaptchaTasksClient != null;
    assert activity != null;
    recaptchaTasksClient
            .executeTask(RecaptchaAction.LOGIN)
            .addOnSuccessListener(
                    activity,
                    new OnSuccessListener<String>() {
                      @Override
                      public void onSuccess(String token) {
                        Log.d(TAG, "onSuccess: executeLoginAction - token generated successfully!");
                        result.success(token);
                      }
                    })
            .addOnFailureListener(
                    activity,
                    new OnFailureListener() {
                      @Override
                      public void onFailure(@NonNull Exception e) {
                        Log.d(TAG, "onFailure: executeLoginAction failed!");
                        Log.e(TAG, "onFailure: executeLoginAction failed!", e);
                        e.printStackTrace();
                        result.error("executeLoginAction error", "Failed to generate token", e);
                      }
                    });
  }
}
