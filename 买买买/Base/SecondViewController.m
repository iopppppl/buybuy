//
//  SecondViewController.m
//  买买买
//
//  Created by huiwen on 16/2/4.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

//如果不加在这里，商品视图控制器会出错
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button setBackgroundImage:[UIImage imageNamed:@"Scan_btn_back_nav@2x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = itme;
    
}

- (void)buttonAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
