//
//  UIImage+Utility.m
//  KnowMeApp
//
//  Created by huixiubao on 16/7/6.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

+ (CGRect)doubleRect:(CGRect)aRect
{
    CGRect newRect = aRect;
    newRect.origin.x *= 2;
    newRect.origin.y *= 2;
    newRect.size.width *= 2;
    newRect.size.height *= 2;
    
    return newRect;
}

+ (CGRect)zoomOutRect:(CGRect)aRect times:(int)times
{
    CGRect newRect = aRect;
    newRect.origin.x *= times;
    newRect.origin.y *= times;
    newRect.size.width *= times;
    newRect.size.height *= times;
    
    return newRect;
}


+ (UIImage *)getResizableImage:(NSString *)aImageName leftCap:(CGFloat)aLeft topCap:(CGFloat)aTop
{
    UIImage *retImage = [UIImage imageNamed:aImageName];
    return [retImage resizableImageWithCapInsets:UIEdgeInsetsMake(aTop, aLeft, retImage.size.height - aTop - 1.0f, retImage.size.width - aLeft - 1.0f)];
}

+ (UIImage *)getBoundsImageFromView:(UIView *)aSourceImageView targetRect:(CGRect)aRect opaque:(BOOL)opaque
{
    if (aSourceImageView == nil)
        return nil;
    
    // 获取整体图片
    UIImage *sourceImage = nil;
    BOOL isHidden = aSourceImageView.hidden;
    [aSourceImageView setHidden:NO]; // 设置hidden属性为NO，保证在iOS7上可以绘制
    UIGraphicsBeginImageContextWithOptions(aRect.size, opaque, 0.0f);
    if ([aSourceImageView drawViewHierarchyInRect:aRect afterScreenUpdates:YES]) {
        sourceImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    else
    {
        [aSourceImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        sourceImage = UIGraphicsGetImageFromCurrentImageContext();
    };
    
    UIGraphicsEndImageContext();
    
    [aSourceImageView setHidden:isHidden];
    
    return sourceImage;
}

+ (UIImage *)getRectImageFromImageView:(UIView *)aSourceImageView targetRect:(CGRect)aRect
{
    UIImage *sourceImage = [[self class] getBoundsImageFromView:aSourceImageView targetRect:aSourceImageView.bounds opaque:NO];
    if (sourceImage == nil)
        return nil;
    
    CGRect needFrame = [[self class] zoomOutRect:aRect times:[UIScreen mainScreen].scale];
    
    CGImageRef targetCGImage = CGImageCreateWithImageInRect(sourceImage.CGImage, needFrame);
    UIImage *returnImage =  [[UIImage alloc] initWithCGImage:targetCGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(targetCGImage);
    
    return returnImage;
}

+ (UIImage*)getBoundsImageFromView:(UIView*)aSourceImageView targetRect:(CGRect)aRect
{
    return [UIImage getBoundsImageFromView:aSourceImageView targetRect:aRect opaque:YES];
}

+ (UIImage *)km_imageWithColor:(UIColor *)color withSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*)km_imageFrom:(UIImage*)aSourceImage inRect:(CGRect)aRect
{
    if (aSourceImage == nil)
        return nil;
    
    CGImageRef imageToSplit = aSourceImage.CGImage;
    CGImageRef partOfImageAsCG = CGImageCreateWithImageInRect(imageToSplit, aRect);
    UIImage *returnImage = [UIImage imageWithCGImage:partOfImageAsCG];
    CGImageRelease(partOfImageAsCG);
    
    return returnImage;
}

+ (UIImage *)km_strechImage:(UIImage *)aOriginImage capInsets:(UIEdgeInsets)aCapInsets resizingMode:(UIImageResizingMode)aResizingMode
{
    if (aOriginImage == nil)
    {
        return nil;
    }
    
    // 仅支持两种拉伸方式（Tile & strench）
    if (aResizingMode != UIImageResizingModeTile && aResizingMode != UIImageResizingModeStretch)
    {
        aResizingMode = UIImageResizingModeStretch;
    }
    UIImage *strechedImage = nil;
    strechedImage = [aOriginImage resizableImageWithCapInsets:aCapInsets resizingMode:aResizingMode];
    
    return strechedImage;
}

+ (UIImage *)km_zoomImage:(UIImage *)aSourceImage zoomRatio:(CGFloat)aRatio
{
    if (aSourceImage == nil)
        return nil;
    
    CGSize newSize = CGSizeMake(floor(aSourceImage.size.width * aRatio), floor(aSourceImage.size.height * aRatio));
    
    // 按照目标区域进行缩放
    UIGraphicsBeginImageContext(newSize);
    [aSourceImage drawInRect:CGRectMake(0.0f, 0.0f, newSize.width, newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+(UIImage *)km_scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+ (UIImage *)km_scale:(UIImage *)image toSize:(CGSize)size
{
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+ (UIImage *)km_rotationImage:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}

+ (UIImage*)km_blurOneImage:(UIImage*)theImage WithBlurNumber:(CGFloat)number WithBrighteness:(CGFloat)brightNumber
{
    CGFloat blurNumber = number;
    
    CGFloat distance = blurNumber + 30;
    CGRect imageRect = CGRectMake(distance, distance, theImage.size.width - distance*2, theImage.size.height - distance * 2);
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    CIImage * result;
    if (brightNumber != 0) {
        CIFilter *colorFilter= [CIFilter filterWithName:@"CIColorControls"];
        [colorFilter setValue:inputImage forKey:kCIInputImageKey];
        [colorFilter setValue:[NSNumber numberWithFloat:brightNumber] forKey:@"inputBrightness"]; //inputBrightness
        result = [colorFilter valueForKey:kCIOutputImageKey];
    }
    
    if (!result) {
        result = inputImage;
    }
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:result forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:blurNumber] forKey:@"inputRadius"];
    
    result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:imageRect];
    
    UIImage * imageAtLast = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageAtLast;
}

+ (UIImage *)km_clipImageWithRect:(UIImage *)image rect:(CGRect)rect
{
    CGRect newRect = [[self class] zoomOutRect:rect times:[UIScreen mainScreen].scale];
    CGImageRef targetCGImage = CGImageCreateWithImageInRect(image.CGImage, newRect);
    UIImage *returnImage =  [[UIImage alloc] initWithCGImage:targetCGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(targetCGImage);
    return returnImage;
}

@end
