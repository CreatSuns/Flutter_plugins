#import "MomentAliRealAuthenticationPlugin.h"
#import <AlipayVerifySDK/APVerifyService.h>
#import <ZolozIdentityManager/ZolozSdk.h>

@implementation MomentAliRealAuthenticationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"moment_ali_real_authentication"
            binaryMessenger:[registrar messenger]];
  MomentAliRealAuthenticationPlugin* instance = [[MomentAliRealAuthenticationPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//  if ([@"getPlatformVersion" isEqualToString:call.method]) {
//    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
    
    if ([call.method isEqualToString:@"init"]) {
        [ZolozSdk init];
    } else if ([call.method isEqualToString:@"getBizCode"]) {
        NSString *bizcode = [[APVerifyService sharedService] bizCode];
        result(bizcode);
    } else if ([call.method isEqualToString:@"goFaceRz"]) {
        if ([call.arguments isKindOfClass:[NSDictionary class]]) {
            NSString *bizcode = [[APVerifyService sharedService] bizCode];
            NSDictionary * dic = call.arguments;
            [[APVerifyService sharedService] startVerifyService:@{@"url": dic[@"url"],
                                                                  @"certifyId": dic[@"certify_id"],
                                                                  @"ext": @"moment-extInfo",@"bizcode":bizcode}
                                                        target:self
                                                         block:^(NSMutableDictionary * resultDic){
                                                                      NSLog(@"%@", resultDic);
                result(resultDic);
                                                                  }];
        }
        result(@{@"result":@"参数错误"});
    } else {
        result(FlutterMethodNotImplemented);
    }
    
}

@end
