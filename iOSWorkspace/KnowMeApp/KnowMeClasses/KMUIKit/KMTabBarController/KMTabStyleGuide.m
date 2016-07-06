//
//  KMTabStyleGuide.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "KMTabStyleGuide.h"

@implementation KMTabStyleGuide

+ (CGFloat)tabDefaultHeight
{
    return 60.0;
}

+ (CGSize)normalIconSize
{
    return CGSizeMake(30, 30);
}

+ (UIFont*)titleFont
{//标题字体
    return [UIFont systemFontOfSize:12.0];
}

+ (CGFloat)titleIconSpacing//标题图标间距
{
    return 1.0;
}

+ (CGFloat)iconTopMargin//图标顶部间距
{
    return 13.0;
}

+ (CGFloat)badgeOffsetY//badge在tabbar上的offsetY
{
    return 3.0;
}

+ (CGFloat)badgeHeight//badge高度
{
    return 16.0;
}

+ (CGFloat)badgeCornerRadius//badge圆角半径
{
    return [[self class] badgeHeight]/2.0;
}

+ (UIColor*)badgeColor//badge背景颜色
{
    return [UIColor RGBColorFromHexString:@"#f13839"];
}

+ (CGFloat)badgeDotRadius//飘点
{
    return 4.0;
}

+ (UIFont*)badgeFont
{
    return [UIFont systemFontOfSize:10.0];
}

+ (UIColor*)badgeFontColor//badge字体颜色
{
    return [UIColor whiteColor];
}

+ (UIColor*)badgeStrokeColor//badge描边颜色
{
    return [UIColor RGBColorFromHexString:@"#ffffff" alpha:0.5];
}

+ (CGFloat)badgeStrokeWidth//badge描边线宽度
{
    return 0.5f;
}

@end
