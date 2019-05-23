#import "FlutterUmengAnalyticsPlugin.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>


@implementation FlutterUmengAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_umeng_analytics"
            binaryMessenger:[registrar messenger]];
  FlutterUmengAnalyticsPlugin* instance = [[FlutterUmengAnalyticsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    if([@"init" isEqualToString:call.method]){
        [self init:call result:result];
        result(nil);
    }else if ([@"userInfo" isEqualToString:call.method]){
        [self userInfo:call result:result];
        result(nil);
    }else if ([@"userInfoOff" isEqualToString:call.method]){
        [self userInfoOff:call result:result];
        result(nil);
    }else if ([@"beginPageView" isEqualToString:call.method]){
        [self beginPageView:call result:result];
        result(nil);
    }else if ([@"endPageView" isEqualToString:call.method]){
        [self endPageView:call result:result];
        result(nil);
    }else if ([@"event" isEqualToString:call.method]){
        [self event:call result:result];
        result(nil);
    }else{
       result(FlutterMethodNotImplemented);
    }
 
}


//init SDK
- (void)init:(FlutterMethodCall*)call result:(FlutterResult)result{
    NSString* appKey = call.arguments[@"appKey"];
    NSString* channel = call.arguments[@"channel"];
    if(!channel) channel = @"flutter";
    [UMConfigure initWithAppkey:appKey channel:channel];
}
- (void) userInfo:(FlutterMethodCall*)call result:(FlutterResult)result{
    [MobClick profileSignInWithPUID:call.arguments[@"userInfo"]];
}
- (void) userInfoOff:(FlutterMethodCall*)call result:(FlutterResult)result{
    [MobClick profileSignOff];
}
- (void) beginPageView:(FlutterMethodCall*)call result:(FlutterResult)result{
    [MobClick beginLogPageView:call.arguments[@"beginPageView"]];
}
- (void) endPageView:(FlutterMethodCall*)call result:(FlutterResult)result{
    [MobClick endLogPageView:call.arguments[@"endPageView"]];
}
- (void) event:(FlutterMethodCall*)call result:(FlutterResult)result{
    [MobClick event:call.arguments[@"event"]];
}

@end
