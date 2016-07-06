//
//  NSString+Size.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "NSString+Size.h"
@implementation NSString (Size)
+ (CGSize)km_sizeOfString:(NSString *)aString withFont:(UIFont *)aFont
{
    CGSize stringSize;
    stringSize = [aString sizeWithAttributes:@{NSFontAttributeName: aFont}];
    stringSize.height = ceil(stringSize.height);
    stringSize.width = ceil(stringSize.width);
    return stringSize;
}

+ (CGSize)km_sizeOfString:(NSString *)aString withFont:(UIFont *)aFont withConstrainedSize:(CGSize)aSize withLineBreakMode:(NSLineBreakMode)aMode
{
    CGSize stringSize;
    NSMutableParagraphStyle *paragraphStyle =[[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = aMode;
    NSDictionary *attributes = @{NSFontAttributeName:aFont, NSParagraphStyleAttributeName:paragraphStyle};
    stringSize = [aString boundingRectWithSize:aSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return stringSize;
}
@end
