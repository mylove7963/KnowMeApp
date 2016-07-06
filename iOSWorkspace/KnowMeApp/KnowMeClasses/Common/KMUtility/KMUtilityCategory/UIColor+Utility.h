//
//  UIColor+Utility.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
// 透明度alpha值
#define ALPHA_VALUE_00   0.00f  // 完全透明
#define ALPHA_VALUE_5    0.05f
#define ALPHA_VALUE_10   0.10f
#define ALPHA_VALUE_15   0.15f
#define ALPHA_VALUE_20   0.20f  //
#define ALPHA_VALUE_25   0.25f
#define ALPHA_VALUE_30   0.30f  //
#define ALPHA_VALUE_35   0.35f
#define ALPHA_VALUE_40   0.40f
#define ALPHA_VALUE_50   0.50f  // 通用页面蒙层
#define ALPHA_VALUE_60   0.60f
#define ALPHA_VALUE_80   0.80f	// 图像识别结果, 拍照识别结果页蒙层
#define ALPHA_VALUE_90   0.90f
#define ALPHA_VALUE_97   0.97f  // 首页的搜索栏
#define ALPHA_VALUE_100  1.00f  // 不透明


@interface UIColor (Utility)
+ (UIColor *)RGBColorFromHexString:(NSString *)aHexStr;
+ (UIColor *)RGBColorFromHexString:(NSString *)aHexStr alpha:(float)aAlpha;
+ (UIColor *)ARGBColorFromHexString:(NSString *)aHexStr; // RGBA的颜色值转换
@end
