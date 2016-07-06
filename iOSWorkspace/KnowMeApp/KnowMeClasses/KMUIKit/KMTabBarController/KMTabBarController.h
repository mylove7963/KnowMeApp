//
//  KMTabBarController.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface KMTabBarController : UIViewController

@property(nullable, nonatomic, copy) NSArray<__kindof NSObject*> *viewControllers;
@property(nullable, nonatomic, assign) __kindof UIViewController  *selectedViewController;
@property(nonatomic) NSInteger                                     selectedIndex;
@property(nonatomic) BOOL                                          displayBadgeDeselected;
@property(nullable, nonatomic,weak) id<UITabBarControllerDelegate> delegate;
@property(nullable, nonatomic,strong) UIImage                     *barBackgroundImage;

- (void)setViewControllers:(NSArray<__kindof UIViewController *> * __nullable)viewControllers animated:(BOOL)animated;
- (void)setBarTintColor:(UIColor*)color forState:(UIControlState)state;
- (void)showViewFromTabBar:(UIView*)view;
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)updateTabBar;

@end

typedef void(^KMTabBarItemClick)(void);

@interface NSObject (KMTabBarControllerItem)

@property (null_resettable, nonatomic, strong) UITabBarItem          *kmTabBarItem;
@property (nullable, nonatomic, readonly, strong) KMTabBarController *kmTabBarController;
@property (nonatomic, copy) KMTabBarItemClick                         kmBarItemClick;
@property (nonatomic, copy) KMTabBarItemClick                         kmBarItemReqpeatClick;

- (UITabBarItem *)kmTabBarItem:(nullable NSString*)title image:(nullable UIImage *)image selectedImage:(nullable UIImage *)selectedImage;

@end

@interface UITabBarItem (KMTabBarItemProperty)

@property (nonatomic, assign) CGFloat            kmWidthRatio;
@property (nonatomic, strong) UIView            *kmCustomView;
@property (nullable, nonatomic, copy) NSString  *kmBadgeValue;
@property (nonatomic, assign) BOOL               kmHasBadge;
@property (nonatomic, readonly) CGRect           kmFrame;
@property (nonatomic, assign)BOOL                kmCannotBeHighlighted;//不能被高亮

@end

NS_ASSUME_NONNULL_END


