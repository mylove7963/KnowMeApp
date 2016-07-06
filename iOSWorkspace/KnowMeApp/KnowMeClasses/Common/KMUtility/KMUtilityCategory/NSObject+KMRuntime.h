//
//  NSObject+KMRuntime.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KMRuntime)
- (BOOL)km_respondsToSelector:(SEL)selector;
- (void)km_printAllMethods;
@end
