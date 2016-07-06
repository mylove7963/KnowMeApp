//
//  KMHomeViewController.m
//  KnowMeApp
//
//  Created by huixiubao on 16/6/30.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "KMHomeViewController.h"


@interface KMHomeViewController ()

@end

@implementation KMHomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil)
    {

        NSString *title =@"我";
//        UIImage *image = [UIImage imageNamed:@"personalcenter_tab_icon_normal.png"];
//        UIImage *selectedImage =  [UIImage imageNamed:@"personalcenter_tab_icon_selected.png"];
//        
        [self kmTabBarItem:title image:nil selectedImage:nil];
        
        __weak KMHomeViewController *weakSelf = self;
        self.kmBarItemClick = ^()
        {
            
        };
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
