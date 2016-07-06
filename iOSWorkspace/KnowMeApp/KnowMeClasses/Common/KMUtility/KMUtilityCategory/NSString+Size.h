//
//  NSString+Size.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

+ (CGSize)km_sizeOfString:(NSString *)aString withFont:(UIFont *)aFont;
+ (CGSize)km_sizeOfString:(NSString *)aString withFont:(UIFont *)aFont withConstrainedSize:(CGSize)aSize withLineBreakMode:(NSLineBreakMode)aMode;

@end
