//
//  BaseNavigationController.m
//  买买买
//
//  Created by huiwen on 16/1/31.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.translucent = NO;
    
    NSDictionary *attri = @{
                            NSForegroundColorAttributeName : [UIColor whiteColor]
                            };
    
    self.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationBar.titleTextAttributes = attri;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = itme;
    
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
