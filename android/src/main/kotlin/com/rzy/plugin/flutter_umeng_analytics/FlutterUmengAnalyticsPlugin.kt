package com.rzy.plugin.flutter_umeng_analytics

import android.app.Activity
import com.umeng.analytics.MobclickAgent
import com.umeng.commonsdk.UMConfigure
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterUmengAnalyticsPlugin: MethodCallHandler {

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_umeng_analytics")
      channel.setMethodCallHandler(FlutterUmengAnalyticsPlugin(registrar.activity()))
    }
  }

  var mActivity: Activity

  constructor(mActivity: Activity) {
    this.mActivity = mActivity
  }


  override fun onMethodCall(call: MethodCall, result: Result) {
    when {
      call.method == "init" -> init(call, result)
      call.method == "userInfo" -> userInfo(call, result)
      call.method == "userInfoOff" -> userInfoOff(call, result)
      call.method == "beginPageView" -> beginPageView(call, result)
      call.method == "endPageView" -> endPageView(call, result)
      call.method == "event" -> event(call, result)
      else -> result.notImplemented()
    }
  }


  /**
   * 初始化
   */
  private fun init(call: MethodCall, result: Result) {
    var channelName = "flutter"
    if (call.argument<String>("channel") as String != null) {
      channelName = call.argument<String>("channel") as String
    }

    UMConfigure.init(mActivity, call.argument<String>("appKey") as String, channelName, UMConfigure.DEVICE_TYPE_PHONE, null)
    result.success(true)
  }

  /**
   * 统计用户  以设备为准
   */
  private fun userInfo(call: MethodCall, result: Result) {
    MobclickAgent.onProfileSignIn(call.argument<String>("userId") as String)
  }

  /**
   * 用户退出
   */
  private fun userInfoOff(call: MethodCall, result: Result) {
    MobclickAgent.onProfileSignOff()
  }


  /**
   * 页面begin
   */
  private fun beginPageView(call: MethodCall, result: Result) {
    MobclickAgent.onPageStart(call.argument<String>("pageName") as String)
    MobclickAgent.onResume(mActivity)
  }

  /**
   * 事件
   */
  private fun event(call: MethodCall, result: Result) {
    MobclickAgent.onEvent(mActivity, call.argument<String>("eventName") as String)
  }

  /**
   * 页面结束
   */
  private fun endPageView(call: MethodCall, result: Result) {
    MobclickAgent.onPageEnd(call.argument<String>("pageName") as String)
    MobclickAgent.onPause(mActivity)
  }
}
