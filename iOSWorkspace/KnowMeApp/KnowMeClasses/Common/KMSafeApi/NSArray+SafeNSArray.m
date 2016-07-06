//
//  NSArray+SafeNSArray.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "NSArray+SafeNSArray.h"

@implementation NSArray (SafeNSArray)

- (id)objectAtIndexSafely:(NSUInteger)index
{
    if (index >= self.count)
    {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
