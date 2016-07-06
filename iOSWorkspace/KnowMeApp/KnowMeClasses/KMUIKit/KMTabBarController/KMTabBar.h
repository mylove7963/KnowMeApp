//
//  KMTabBar.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMTabBar : UIView

@property(nullable, nonatomic,strong) UIImage *backgroundImage;

@property(null_resettable, nonatomic,strong) UIColor *normalTintColor;
@property(null_resettable, nonatomic,strong) UIColor *highlightTintColor;

- (CGRect)itemRect:(NSInteger)index;

- (void)updateWithItems:(nonnull NSArray*)items index:(NSInteger)index selected:(void (^ __nullable)(NSInteger index))completion;

@end

NS_ASSUME_NONNULL_END