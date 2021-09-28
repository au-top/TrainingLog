package com.example.sharedpreferences

import android.app.Activity
import android.content.Context
import android.content.SharedPreferences
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SharedpreferencesPlugin */
class SharedpreferencesPlugin: FlutterPlugin, MethodCallHandler ,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var  activity:Activity
  private lateinit var sharedPreferences: SharedPreferences
  private lateinit var  edit:SharedPreferences.Editor;
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sharedpreferences")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method){
      "put"->{
        val k=call.argument<String>("key");
        val v=call.argument<Any>("value");
        if (k!=null&&v!=null){
          save(k,v);
        }else{
          Log.d("$k : $v");
        }
      }
    }
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  fun save(key:String,saveValue:Any){
    when(saveValue){
      is Boolean->{
        edit.putBoolean(key,saveValue);
      }
      is Float->{
        edit.putFloat(key,saveValue);
      }
      is Int->{
        edit.putInt(key,saveValue);
      }
      is Long->{
        edit.putLong(key,saveValue);
      }
      is String->{
        edit.putString(key,saveValue);
      }
      else ->{
        edit.putString(key, saveValue.toString());
      }
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity=binding.activity
    sharedPreferences=activity.getSharedPreferences("mysp_1", Context.MODE_PRIVATE)
    edit=sharedPreferences.edit();

  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onDetachedFromActivity() {
  }
}
