//
//  KMTabStyleGuide.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMTabStyleGuide : NSObject

+ (CGFloat)tabDefaultHeight;//tab默认高度
+ (UIFont*)titleFont;//标题字体
//icon
+ (CGSize)normalIconSize;//普通图标大小
+ (CGFloat)titleIconSpacing;//标题图标间距
+ (CGFloat)iconTopMargin;//图标顶部间距
//badge
+ (CGFloat)badgeOffsetY;//badge在tabbar上的offsetY
+ (CGFloat)badgeHeight;//badge高度
+ (CGFloat)badgeCornerRadius;//badge圆角半径
+ (UIColor*)badgeColor;//badge背景颜色
+ (CGFloat)badgeDotRadius;//飘点半径
+ (UIFont*)badgeFont;//badge字体
+ (UIColor*)badgeFontColor;//badge字体颜色
+ (UIColor*)badgeStrokeColor;//badge描边颜色
+ (CGFloat)badgeStrokeWidth;//badge描边线宽度
@end
