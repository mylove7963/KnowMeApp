//
//  ReactNative.m
//  KMPods
//
//  Created by huixiubao on 16/7/7.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "ReactNative.h"
#import "RCTRootView.h"
#import "RCTBundleURLProvider.h"

@implementation ReactNative
+ (instancetype)shareInstance
{
    static ReactNative *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _shareInstance = [[ReactNative alloc] init];
    });
    
    return _shareInstance;
}

//- (RCTRootView *)loadRCTRootView
//{
//    
//    NSURL *jsCodeLocation;
//    
//    [[RCTBundleURLProvider sharedSettings] setDefaults];
//    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
//    
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                        moduleName:@"KMReact"
//                                                 initialProperties:nil
//                                                     launchOptions:nil];
//    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
//    
//    return rootView;
//
//}
@end
