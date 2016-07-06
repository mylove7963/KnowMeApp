//
//  NSMutableArray+SafeNSMutableArray.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "NSMutableArray+SafeNSMutableArray.h"

@implementation NSMutableArray (SafeNSMutableArray)

- (void)addObjectSafely:(id)anObject
{
    if (anObject == nil)
    {
        return;
    }
    [self addObject:anObject];
}

- (void)addObjectsFromArraySafely:(NSArray *)otherArray
{
    if (otherArray == nil)
    {
        return;
    }
    [self addObjectsFromArray:otherArray];
}

- (void)insertObjectSafely:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil)
    {
        return;
    }
    if (index > self.count)
    {
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)replaceObjectAtIndexSafely:(NSUInteger)index withObject:(id)anObject
{
    if (anObject == nil)
    {
        return;
    }
    if (index >= self.count)
    {
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)removeLastObjectSafely
{
    if (self.count == 0)
    {
        return;
    }
    [self removeLastObject];
}

- (void)removeObjectAtIndexSafely:(NSUInteger)index
{
    if (index >= self.count)
    {
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)exchangeObjectAtIndexSafely:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if (idx1 >= self.count || idx2 >= self.count)
    {
        return;
    }
    [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (id)objectAtIndexSafely:(NSUInteger)index
{
    if (index >= self.count)
    {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
