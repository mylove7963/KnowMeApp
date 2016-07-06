//
//  KMStackController.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "KMStackController.h"
#include <objc/runtime.h>

@interface KMStackController ()
{
    NSMutableArray      *_viewControllers;
}
@end


@interface NSObject ()

@property(nullable, nonatomic, strong, setter=setKMStackController:) KMStackController *kmStackController;

@end

@implementation KMStackController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init])
    {
        _viewControllers = [[NSMutableArray alloc] init];
        [_viewControllers addObject:rootViewController];
    }
    
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.view.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:viewController.view];
    [viewController willMoveToParentViewController:self];
    //动画
    [viewController didMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [_viewControllers addObject:viewController];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *controller = [_viewControllers lastObject];
    [controller removeFromParentViewController];
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller didMoveToParentViewController:nil];
    
    [_viewControllers removeLastObject];
    return controller;
}

- (nullable UIViewController *)popViewController:(Class)controllerClass Animated:(BOOL)animated
{
    return nil;
}

- (void)loadView
{
    [super loadView];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    UIViewController    *rootViewController = [_viewControllers firstObject];
    rootViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:rootViewController.view];
    [rootViewController didMoveToParentViewController:self];
    [self addChildViewController:rootViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 横竖屏相关，通过容器链式查找确定横竖屏属性
- (BOOL)shouldAutorotate
{
    UIViewController *topViewController = [_viewControllers lastObject];
    if (topViewController && [topViewController respondsToSelector:@selector(shouldAutorotate)])
    {
        return [topViewController shouldAutorotate];
    }
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *topViewController = [_viewControllers lastObject];
    if (topViewController && [topViewController respondsToSelector:@selector(supportedInterfaceOrientations)])
    {
        return [topViewController supportedInterfaceOrientations];
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark 状态栏管理
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    UIViewController *topViewController = [_viewControllers lastObject];
    if ([topViewController respondsToSelector:@selector(preferredStatusBarStyle)])
    {
        style = [topViewController preferredStatusBarStyle];
    }
    
    return style;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    UIStatusBarAnimation animation = UIStatusBarAnimationNone;
    UIViewController *topViewController = [_viewControllers lastObject];
    if ([topViewController respondsToSelector:@selector(preferredStatusBarUpdateAnimation)])
    {
        animation = [topViewController preferredStatusBarUpdateAnimation];
    }
    
    return animation;
}

- (BOOL)prefersStatusBarHidden{
    BOOL hidden = NO;
    UIViewController *topViewController = [_viewControllers lastObject];
    if ([topViewController respondsToSelector:@selector(prefersStatusBarHidden)])
    {
        hidden = [topViewController prefersStatusBarHidden];
    }
    
    return hidden;
}

@end

@implementation NSObject (KMStackControllerItem)
static char kmStackControllerKey;

- (void)setKmStackController:(KMStackController*)controller
{
    objc_setAssociatedObject(self, &kmStackControllerKey, controller, OBJC_ASSOCIATION_ASSIGN);
}

- (KMStackController*)kmStackController
{
    return objc_getAssociatedObject(self, &kmStackControllerKey);
}
@end
