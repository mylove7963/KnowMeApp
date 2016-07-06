//
//  KMTabBarController.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "KMTabBarController.h"
#import "KMStackController.h"
#import "KMTabBar.h"
#import "KMTabStyleGuide.h"
#include <objc/runtime.h>
#import "NSObject+KMRuntime.h"


#define kKMTabBarFrame (CGRectMake(0.0f, [UIScreen getApplicationSize].height - [KMTabStyleGuide tabDefaultHeight], [UIScreen getApplicationSize].width, [KMTabStyleGuide tabDefaultHeight]))

@interface NSObject (KMTabBarControllerItem)

@property(nullable, nonatomic, strong, setter=setKmTabBarController:) KMTabBarController *kmTabBarController;

@end

@interface KMTabBarController ()
{
    NSArray             *_viewControllers;
    KMTabBar            *_tabBar;
    UIColor             *_normalTintColor;
    UIColor             *_highlightTintColor;
    NSMutableArray      *_tabItems;
}

- (void)updateTabs;
- (CGRect)tabItemsRect:(UITabBarItem*)item;

@end

@implementation KMTabBarController
@synthesize delegate;

- (instancetype)init
{
    if (self = [super init])
    {
        _selectedIndex = -1;
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        CGRect tabRect = kKMTabBarFrame;
        _tabBar = [[KMTabBar alloc] initWithFrame:tabRect];
        _tabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _tabBar.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化各元素的bbaTabBarItem
    [self updateTabBar];
    [self setDefaultIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    if (index == _selectedIndex) {
        return;
    }
    [self setDefaultIndex:index];
}

- (void)viewWillLayoutSubviews {

    [super viewWillLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)updateTabs
{
    [_tabBar updateWithItems:_tabItems index:_selectedIndex selected:^(NSInteger idx) {
        UIViewController *weakSelectedController = [_viewControllers objectAtIndexSafely:_selectedIndex];
        
        if (_selectedIndex == idx)//回调双击的block
        {
            if (weakSelectedController.kmBarItemReqpeatClick)
            {
                weakSelectedController.kmBarItemReqpeatClick();
            }
            else if ([weakSelectedController isKindOfClass:[UINavigationController class]])
            {
                UINavigationController *navigationController = (UINavigationController*)weakSelectedController;
                UIViewController *viewController = [navigationController.viewControllers firstObject];
                if (viewController.kmBarItemReqpeatClick)
                {
                    viewController.kmBarItemReqpeatClick();
                }
            }
        }
        else
        {
            UIViewController *weakSelectedController = [_viewControllers objectAtIndexSafely:idx];
            if (weakSelectedController.kmBarItemClick)
            {
                weakSelectedController.kmBarItemClick();
            }
            else if ([weakSelectedController isKindOfClass:[UINavigationController class]])
            {
                UINavigationController *navigationController = (UINavigationController*)weakSelectedController;
                UIViewController *viewController = [navigationController.viewControllers firstObject];
                if (viewController.kmBarItemClick)
                {
                    viewController.kmBarItemClick();
                }
            }
            [self didSelectedIndex:idx];
        }
    }];
}

- (CGRect)tabItemsRect:(UITabBarItem*)item
{
    __block NSInteger index;
    __block NSObject  *elem;//tab中的VC
    [_viewControllers enumerateObjectsUsingBlock:^(UINavigationController *obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if ([obj isKindOfClass:[UINavigationController class]])
         {
             elem =  [obj.viewControllers firstObject];
         }
         else
         {
             elem = obj;
         }
         
         if (item == elem.kmTabBarItem)
         {
             index = idx;
             *stop = YES;
         }
     }];
    
    CGRect tabItemRect = [_tabBar itemRect:index];
    
    return [_tabBar.superview convertRect:tabItemRect fromView:_tabBar];
}

- (void)setDefaultIndex:(NSInteger)index
{
    [self didSelectedIndex:index];
    [self updateTabs];
}

- (void)didSelectedIndex:(NSInteger)index{
    UIViewController *selectedController = [_viewControllers objectAtIndexSafely:index];
    UIViewController *currentController = [_viewControllers objectAtIndexSafely:_selectedIndex];
    
    if (_selectedIndex != -1) {//非首次展示
        //移除原来的
        [_tabBar removeFromSuperview];
        [currentController removeFromParentViewController];
        [currentController willMoveToParentViewController:nil];
        [currentController.view removeFromSuperview];
        [currentController didMoveToParentViewController:nil];
    }
    
    _selectedIndex = index;
    
    //添加选中的
    if (![selectedController isKindOfClass:[UIViewController class]])
    {
        return;
    }
    [selectedController willMoveToParentViewController:self];
    selectedController.view.frame = [UIScreen mainScreen].bounds;
    if ([selectedController isKindOfClass:[UINavigationController class]])
    {
        NSArray *vcs = ((UINavigationController*)selectedController).viewControllers;
        UIViewController *rootVC = [vcs objectAtIndex:0];
        rootVC.view.bounds = [UIScreen mainScreen].bounds;
        [rootVC.view addSubview:_tabBar];//本应该加在self.view上，但因为出现Tab一直浮在UINavigationController所有子控制器View上，因此加在根控制器的view底部
    }
    else{
        [selectedController.view addSubview:_tabBar];
    }
    
    //    [self.view insertSubview:selectedController.view belowSubview:_tabBar];
    selectedController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:selectedController.view];
    [selectedController didMoveToParentViewController:self];
    [self addChildViewController:selectedController];
    
    //刷新状态栏Style
    [self updateStatusBarFrom:currentController toController:selectedController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //外部事件处理，In-Call等
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showViewFromTabBar:(UIView*)view{//从当前高亮的tab弹出view
    
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    CGRect rect = kKMTabBarFrame;
    UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseIn;
    if (hidden)
    {
        rect.origin.y += [KMTabStyleGuide tabDefaultHeight];
        option = UIViewAnimationOptionCurveEaseOut;
    }
    
    if (!CGRectEqualToRect(_tabBar.frame, rect))
    {
        if (animated)
        {
            [UIView animateWithDuration:0.3 delay:0 options:option animations:^{
                _tabBar.frame = rect;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            _tabBar.frame = rect;
        }
    }
}

- (void)updateTabItemsData
{
    if (!_tabItems)
    {
        _tabItems = [[NSMutableArray alloc] init];
    }
    else
    {
        [_tabItems removeAllObjects];
    }
    
    UIViewController *headViewController = nil;
    UITabBarItem *item = nil;
    NSInteger i = 0;
    for (NSObject *elem in _viewControllers)
    {
        item = elem.kmTabBarItem;
        if (!item)
        {
            if ([elem isKindOfClass:[UINavigationController class]])
            {
                UINavigationController *naviController = (UINavigationController*)elem;
                UIViewController *controller = [naviController.viewControllers firstObject];
                item = controller.kmTabBarItem;
                
            }
            
            if (!item)
            {
                item = [[UITabBarItem alloc] init];
            }
        }
        
        elem.kmTabBarController = self;
        item.kmTabBarController = self;
        
        if ([elem isKindOfClass:[UIViewController class]])
        {
            if (!headViewController && _selectedIndex<0)//首次默认index
            {
                headViewController = (UIViewController*)elem;
                _selectedIndex = i;
            }
        }
        if (self.kmStackController)
        {

        }
        i++;
        
        [_tabItems addObjectSafely:item];
    }
}

- (void)updateTabBar
{
    [self updateTabItemsData];
    [self updateTabs];
}

- (void)setBarTintColor:(UIColor*)color forState:(UIControlState)state
{
    if (state == UIControlStateNormal)
    {
        _normalTintColor = color;
        _tabBar.normalTintColor = color;
    }
    else if (state == UIControlStateHighlighted)
    {
        _highlightTintColor = color;
        _tabBar.highlightTintColor = color;
    }
}

- (void)setBarBackgroundImage:(UIImage *)image
{
    _barBackgroundImage = image;
    _tabBar.backgroundImage = image;
}

#pragma mark - Status Bar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    UIViewController *controller = [_viewControllers objectAtIndexSafely:_selectedIndex];
    if ([controller respondsToSelector:@selector(preferredStatusBarStyle)])
    {
        style = [controller preferredStatusBarStyle];
    }
    
    return style;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    UIStatusBarAnimation animation = UIStatusBarAnimationNone;
    UIViewController *controller = [_viewControllers objectAtIndexSafely:_selectedIndex];
    if ([controller respondsToSelector:@selector(preferredStatusBarUpdateAnimation)])
    {
        animation = [controller preferredStatusBarUpdateAnimation];
    }
    
    return animation;
}

- (void)updateStatusBarFrom:(UIViewController*)from toController:(UIViewController*)to
{
    UIStatusBarStyle fromStyle = UIStatusBarStyleDefault;
    if ([from respondsToSelector:@selector(preferredStatusBarStyle)])
    {
        fromStyle = [from preferredStatusBarStyle];
    }
    
    UIStatusBarStyle toStyle = UIStatusBarStyleDefault;
    if ([to respondsToSelector:@selector(preferredStatusBarStyle)])
    {
        toStyle = [from preferredStatusBarStyle];
    }
    
    if (!from || fromStyle !=toStyle)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
}

#pragma mark 横竖屏相关，通过容器链式查找确定横竖屏属性
- (BOOL)shouldAutorotate
{
    if (_selectedIndex<0)//还未初始化好
    {
        return NO;
    }
    
    UIViewController *topViewController = [_viewControllers objectAtIndexSafely:_selectedIndex];
    if (topViewController && [topViewController km_respondsToSelector:@selector(shouldAutorotate)])
    {
        return [topViewController shouldAutorotate];
    }
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (_selectedIndex<0)//还未初始化好
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    
    UIViewController *topViewController = [_viewControllers objectAtIndexSafely:_selectedIndex];
    if (topViewController && [topViewController km_respondsToSelector:@selector(supportedInterfaceOrientations)])
    {
        return [topViewController supportedInterfaceOrientations];
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

@end



@implementation NSObject (KMTabBarControllerItem)
static char kmTabBarItemKey;
static char kmTabBarControllerKey;
static char kmBarItemClickKey;
static char kmBarItemReqpeatClickKey;

- (KMTabBarController*)kmTabBarController
{
    return objc_getAssociatedObject(self, &kmTabBarControllerKey);
}

- (void)setKmTabBarController:(KMTabBarController * _Nullable)kmTabBarController
{
    objc_setAssociatedObject(self, &kmTabBarControllerKey, kmTabBarController, OBJC_ASSOCIATION_ASSIGN);
}

- (UITabBarItem *)kmTabBarItem
{
    UITabBarItem *item = objc_getAssociatedObject(self, &kmTabBarItemKey);
    return item;
}

- (UITabBarItem *)kmTabBarItem:(nullable NSString*)title image:(nullable UIImage *)image selectedImage:(nullable UIImage *)selectedImage
{
    UITabBarItem *itemCopy =[self kmTabBarItem];//备份旧属性
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];//UIKit中貌似不支持对UIBarItem中属性单独赋值
    if (itemCopy)
    {
        item.kmWidthRatio = itemCopy.kmWidthRatio;
        item.kmCustomView = itemCopy.kmCustomView;
        item.kmBadgeValue = itemCopy.kmBadgeValue;
        item.kmHasBadge = itemCopy.kmHasBadge;
        item.kmTabBarController = itemCopy.kmTabBarController;
        item.kmCannotBeHighlighted = itemCopy.kmCannotBeHighlighted;

    }
    
    objc_setAssociatedObject(self, &kmTabBarItemKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return item;
}


- (void)setKmTabBarItem:(UITabBarItem*)item
{
    objc_setAssociatedObject(self, &kmTabBarItemKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKmBarItemClick:(KMTabBarItemClick)block
{
    objc_setAssociatedObject(self, &kmBarItemClickKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (KMTabBarItemClick)kmBarItemClick
{
    return objc_getAssociatedObject(self, &kmBarItemClickKey);
}

- (void)setKmBarItemReqpeatClick:(KMTabBarItemClick)block
{
    objc_setAssociatedObject(self, &kmBarItemReqpeatClickKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (KMTabBarItemClick)kmBarItemReqpeatClick
{
    return objc_getAssociatedObject(self, &kmBarItemReqpeatClickKey);
}
@end




@implementation UITabBarItem (KMTabBarItemProperty)
static char kmWidthRatioKey;
static char kmCustomViewKey;
static char kmBadgeValueKey;
static char kmHasBadgeKey;
static char kmFrameKey;
static char kmCannotBeHighlightedKey;

- (void)setKmWidthRatio:(CGFloat)ratio
{
    objc_setAssociatedObject(self, &kmWidthRatioKey, [NSNumber numberWithFloat:ratio], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)kmWidthRatio
{
    NSNumber *number = objc_getAssociatedObject(self, &kmWidthRatioKey);
    return [number floatValue];
}

- (UIView*)kmCustomView
{
    return objc_getAssociatedObject(self, &kmCustomViewKey);
}

- (void)setKmCustomView:(UIView*)view
{
    objc_setAssociatedObject(self, &kmCustomViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setKmBadgeValue:(NSString *)kmBadgeValue
{
    objc_setAssociatedObject(self, &kmBadgeValueKey, kmBadgeValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //触发刷新
    KMTabBarController *tabController = self.kmTabBarController;
    [tabController updateTabs];
}

- (NSString*)kmBadgeValue
{
    return objc_getAssociatedObject(self, &kmBadgeValueKey);
}

- (void)setKmHasBadge:(BOOL)hasBadge
{
    objc_setAssociatedObject(self, &kmHasBadgeKey, [NSNumber numberWithBool:hasBadge], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //触发刷新
    KMTabBarController *tabController = self.kmTabBarController;
    [tabController updateTabs];
}

- (BOOL)kmHasBadge
{
    NSNumber *number = objc_getAssociatedObject(self, &kmHasBadgeKey);
    return [number floatValue];
}

- (CGRect)kmFrame
{
    KMTabBarController *tabController = self.kmTabBarController;
    return [tabController tabItemsRect:self];
}

- (void)setKmCannotBeHighlighted:(BOOL)highlighted
{
    objc_setAssociatedObject(self, &kmCannotBeHighlightedKey, [NSNumber numberWithFloat:highlighted], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)kmCannotBeHighlighted
{
    NSNumber *highlighted = objc_getAssociatedObject(self, &kmCannotBeHighlightedKey);
    
    return [highlighted boolValue];
}

@end





