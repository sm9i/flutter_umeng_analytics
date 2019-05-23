import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class UMengAnalytics {
  static const MethodChannel _channel =
  const MethodChannel('flutter_umeng_analytics');


  /// 初始化
  /// [channel] 渠道名称 不设置默认为flutter
  static Future init(String androidAppKey, String iosAppKey, {String channel}) {
    String appKey = Platform.isAndroid ? androidAppKey : iosAppKey;
    Map<String, dynamic> args = new Map();
    args['appKey'] = appKey;
    if (channel != null) {
      args['channel'] = channel;
    }
    return _channel.invokeMethod("init", args);
  }

  /// 页面打开
  static Future beginPageView(String pageNme) {
    return _channel.invokeMethod("beginPageView", {"pageName": pageNme});
  }

  /// 页面关闭
  static Future endPageView(String pageName) {
    return _channel.invokeMethod("endPageView", {"pageName": pageName});
  }

  /// user登录
  static Future userInfo(String userId) {
    return _channel.invokeMethod("userInfo", {"userId": userId});
  }

  /// user 退出
  static Future userInfoOff(String userId) {
    return _channel.invokeMethod("userInfoOff", {"userId": userId});
  }

  ///事件
  static Future event(String eventName) {
    return _channel.invokeMethod("event", {"eventName": eventName});
  }
}
