//
//  UIImage+Utility.h
//  KnowMeApp
//
//  Created by huixiubao on 16/7/6.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)
// 获取九宫格拉伸图片，兼容不同SDK，对于特殊需求需要使用系统函数自己实现
+ (UIImage *)getResizableImage:(NSString *)aImageName leftCap:(CGFloat)aLeft topCap:(CGFloat)aTop;
// 从指定视图[aSourceImageView]中获取[aRect]区域的图像
+ (UIImage *)getRectImageFromImageView:(UIView *)aSourceImageView targetRect:(CGRect)aRect;
//从指定图中获取aRect图像，origin为0,0
+ (UIImage *)getBoundsImageFromView:(UIView *)aSourceImageView targetRect:(CGRect)aRect opaque:(BOOL)opaque;
//从指定图中获取aRect图像，origin为0,0
+ (UIImage*)getBoundsImageFromView:(UIView*)aSourceImageView targetRect:(CGRect)aRect;
// 使用color生成UIImage
+ (UIImage *)km_imageWithColor:(UIColor *)color withSize:(CGSize)size;

// 从aSourceImage的aRect区域创建UIImage
+ (UIImage*)km_imageFrom:(UIImage*)aSourceImage inRect:(CGRect)aRect;

// --图片缩放
+ (UIImage *)km_zoomImage:(UIImage *)aSourceImage zoomRatio:(CGFloat)aRatio; // 将图片等比例缩放
+ (UIImage *)km_strechImage:(UIImage *)aOriginImage capInsets:(UIEdgeInsets)aCapInsets resizingMode:(UIImageResizingMode)aResizingMode; // 拉伸图片(区域拉伸)
+ (UIImage *)km_scaleImage:(UIImage *)image toScale:(float)scaleSize;
+ (UIImage *)km_scale:(UIImage *)image toSize:(CGSize)size;
// --图片旋转
+ (UIImage *)km_rotationImage:(UIImage *)image rotation:(UIImageOrientation)orientation;

+ (UIImage*)km_blurOneImage:(UIImage*)theImage WithBlurNumber:(CGFloat)number WithBrighteness:(CGFloat)brightNumber;

+ (UIImage *)km_clipImageWithRect:(UIImage *)image rect:(CGRect)rect;


@end
