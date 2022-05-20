package store.moment.app.moment_ali_real_authentication;

import android.app.Activity;
import android.content.Context;
import android.widget.Toast;


import androidx.annotation.NonNull;

import com.alipay.mobile.android.verify.sdk.ServiceFactory;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alipay.mobile.android.verify.sdk.interfaces.ICallback;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

/** MomentAliRealAuthenticationPlugin */
public class MomentAliRealAuthenticationPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  private Activity activity;


  @Override
  public void onDetachedFromActivity() {

  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "moment_ali_real_authentication");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("init")) {

    } else  if (call.method.equals("getBizCode")) {
      String bizCode = ServiceFactory.build().getBizCode(context);
      result.success(bizCode);
    } else if (call.method.equals("goFaceRz")){
      String bizCode = ServiceFactory.build().getBizCode(context);
      Map map = (Map) call.arguments;
      JSONObject requestInfo = new JSONObject();
      requestInfo.put("bizCode", bizCode);
      requestInfo.put("url", map.get("url"));
      requestInfo.put("certifyId", map.get("certify_id"));
      ServiceFactory.init(context);
      ServiceFactory.build().startService(activity, requestInfo, new ICallback() {
        @Override
        public void onResponse(Map<String, String> response) {
          String responseCode = response.get("resultStatus");
          if ("9001".equals(responseCode)) {
            // 9001需要等待回调/回前台查询认证结果
            result.success(JSON.toJSONString(response));
          } else {
            result.error("0", "调用错误", JSON.toJSONString(response));
          }
          // 回调处理
          // JSON.toJSONString(response)
        }
      });
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
