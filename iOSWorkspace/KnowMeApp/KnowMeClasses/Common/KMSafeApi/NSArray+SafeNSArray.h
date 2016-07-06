//
//  NSArray+SafeNSArray.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeNSArray)

- (id)objectAtIndexSafely:(NSUInteger)index;

@end
