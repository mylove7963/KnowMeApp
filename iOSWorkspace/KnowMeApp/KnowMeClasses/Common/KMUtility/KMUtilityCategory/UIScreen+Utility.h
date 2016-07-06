//
//  UIScreen+Utility.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Utility)
+ (CGSize)km_getApplicationSize;

+ (CGFloat)getScreenWidth;
+ (CGFloat)getScreenHeight;
+ (NSString *)getScreenResolution;
+ (CGSize)getScreenResolutionSize;
+ (CGSize)getApplicationSize;

+ (CGFloat)applicationFrameWidth;
+ (CGFloat)applicationFrameHeight;
@end
