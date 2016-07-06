//
//  NSObject+KMRuntime.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "NSObject+KMRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (KMRuntime)
- (BOOL)km_respondsToSelector:(SEL)selector
{
    unsigned int outCount = 0;
    BOOL response = NO;
    Method *mothodList = class_copyMethodList([self class], &outCount);
    for (int i = 0; i < outCount; i ++)
    {
        if (method_getName(mothodList[i]) == selector)
        {
            response = YES;
            break;
        }
    }
    
    free(mothodList);
    
    return response;
}

- (void)km_printAllMethods
{
#ifdef DEBUG
    unsigned int outCount = 0;
    BOOL response = NO;
    Method *mothodList = class_copyMethodList([self class], &outCount);
    for (int i = 0; i < outCount; i ++)
    {
        NSLog(@"%@\n", NSStringFromSelector(method_getName(mothodList[i])));
    }
    
    free(mothodList);
#endif
}

@end
