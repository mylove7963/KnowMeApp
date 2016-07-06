//
//  KMGlobalTool.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#ifndef KMGlobalTool_h
#define KMGlobalTool_h


// check字符串
#define CHECK_STRING_VALID(targetString)				\
(targetString != nil && [targetString isKindOfClass:[NSString class]] && [targetString length] > 0)



#define AUTORELEASE(x) [x autorelease]




// 系统版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] cachedSystemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_EQUAL_TO(v)  ([[[UIDevice currentDevice] cachedSystemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_LOWWER_THAN(v)  ([[[UIDevice currentDevice] cachedSystemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


#endif /* KMGlobalTool_h */
