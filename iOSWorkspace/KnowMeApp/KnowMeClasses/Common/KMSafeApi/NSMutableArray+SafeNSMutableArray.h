//
//  NSMutableArray+SafeNSMutableArray.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SafeNSMutableArray)

- (void)addObjectSafely:(id)anObject;
- (void)addObjectsFromArraySafely:(NSArray *)otherArray;
- (void)insertObjectSafely:(id)anObject atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndexSafely:(NSUInteger)index withObject:(id)anObject;
- (void)removeLastObjectSafely;
- (void)removeObjectAtIndexSafely:(NSUInteger)index;
- (void)exchangeObjectAtIndexSafely:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (id)objectAtIndexSafely:(NSUInteger)index;

@end
