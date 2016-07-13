//
//  KMAppDelegate.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/28.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "KMAppDelegate.h"
#import "KMHomeViewController.h"
#import "KMRelationViewController.h"
#import "KMTabBarController.h"
#import "KMStackController.h"
#import "KMPods.h"

@interface KMAppDelegate ()

@end

@implementation KMAppDelegate
@synthesize mainWindow;

- (void)createMainWindow
{
    if(!self.mainWindow)
    {
        self.mainWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.mainWindow.backgroundColor = [UIColor blackColor];
    }
    
    [self.mainWindow makeKeyAndVisible];
}

- (UIViewController *)rootViewController
{
    
    NSMutableArray *tabItems = [[NSMutableArray alloc] init];
    KMHomeViewController *homeController = [[KMHomeViewController alloc] init];
    
    UINavigationController *homeNavicontroller = [[UINavigationController alloc] initWithRootViewController:homeController];
    [tabItems addObjectSafely:homeNavicontroller];
    
//    KMRelationViewController *relationController = [[KMRelationViewController alloc] init];
//    UINavigationController *relationNavicontroller = [[UINavigationController alloc] initWithRootViewController:relationController];
//    [tabItems addObjectSafely:relationNavicontroller];
    
    KMTabBarController *tabController = [[KMTabBarController alloc] init];
//    tabController.barBackgroundImage = [UIImage getResizableImage:@"tab_bar_background" leftCap:STRETCH_IMAGE_WITH_LEFT_CAPWIDTH_2 topCap:STRETCH_IMAGE_WITH_TOP_CAPHEIGHT_15];;//TODO:按换肤设置
//    [tabController setBarTintColor:[UIColor RGBColorFromHexString:@"$999999"] forState:UIControlStateNormal];
//    [tabController setBarTintColor:[UIColor RGBColorFromHexString:@"#3c76ff"] forState:UIControlStateHighlighted];
    [tabController setTabBarHidden:YES animated:NO];
    
    tabController.viewControllers = tabItems;
    
    KMStackController *stackController = [[KMStackController alloc] initWithRootViewController:tabController];
    return stackController;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createMainWindow];
    
    self.mainWindow.rootViewController = [self rootViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
 
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
