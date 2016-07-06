//
//  UIScreen+Utility.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "UIScreen+Utility.h"
#import "KMGlobalTool.h"

@implementation UIScreen (Utility)

+ (CGSize)getApplicationSize
{
    return [self bba_getApplicationSize];
}

+ (CGSize)bba_getApplicationSize
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    CGFloat w = size.width;
    CGFloat h = size.height;
    
    if (h < w) {
        size = CGSizeMake(h, w);
    }
    
    return size;
}

+ (NSString *)getScreenResolution
{
    NSInteger width = [[UIScreen mainScreen] currentMode].size.width;
    NSInteger height = [[UIScreen mainScreen] currentMode].size.height;
    NSString *result = [[NSString alloc] initWithFormat:@"%ld_%ld", (long)width, (long)height];
    return result;
}

+ (CGSize)getScreenResolutionSize
{
    return [[UIScreen mainScreen] currentMode].size;
}

+ (CGFloat)getScreenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)getScreenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)applicationFrameWidth{
    return [[self class] bba_getApplicationSize].width;
}

+ (CGFloat)applicationFrameHeight{
    return [[self class] bba_getApplicationSize].height;
}


@end
