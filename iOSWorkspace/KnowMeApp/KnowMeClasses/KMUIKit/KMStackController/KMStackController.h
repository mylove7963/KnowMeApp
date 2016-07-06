//
//  KMStackController.h
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMStackController : UIViewController

@property(nullable,nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers;

@property(nullable, nonatomic, weak) id<UINavigationControllerDelegate> delegate;

@property(nullable, nonatomic, readonly) UIGestureRecognizer *interactivePopGestureRecognizer;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;

- (nullable UIViewController *)popViewController:(Class)controllerClass Animated:(BOOL)animated;

@end


@interface NSObject (KMStackControllerItem)

@property(nullable, nonatomic,readonly,strong) KMStackController *kmStackController;

@end

NS_ASSUME_NONNULL_END

