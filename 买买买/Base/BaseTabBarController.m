//
//  BaseTabBarController.m
//  买买买
//
//  Created by huiwen on 16/1/31.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabBarItem.h"

@interface BaseTabBarController ()

{
    UIImageView *_selectView;
    NSArray *_selectImgArray;
    CGFloat width;
    CGFloat height;
}

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _createTabBar];
}

- (void)_createTabBar
{
    for (UIView *view in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *imgArray = @[@"TabBar_home",
                          @"TabBar_gift",
                          @"TabBar_category",
                          @"TabBar_me_boy"];
    
    _selectImgArray = @[@"TabBar_home_selected",
                          @"TabBar_gift_selected",
                          @"TabBar_category_selected",
                          @"TabBar_me_boy_selected"];
    NSArray *titleArray = @[@"首页",@"热门",@"分类",@"个人中心"];
    
    width = kScreenWidth / imgArray.count;
    height = self.tabBar.frame.size.height;
    
    for (int i = 0; i < imgArray.count; i++) {
        
        
        NSString *imgName = imgArray[i];
        NSString *title = titleArray[i];
        
        CGRect frame = CGRectMake(i * width, 0, width, height);
        
        BaseTabBarItem *item = [[BaseTabBarItem alloc] initWithFrame:frame imageName:imgName title:title];
        item.tag = 100 + i;
        if (i == 0) {
            item.isSelect = YES;
        }
        
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:item];
        
        
    }
    
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake((width - 26) / 2, 5, 26, 26)];
    _selectView.image = [UIImage imageNamed:_selectImgArray[0]];
    
    [self.tabBar addSubview:_selectView];
    
    
}

- (void)itemAction:(BaseTabBarItem *)item
{
    self.selectedIndex = item.tag - 100;
    
    for (int i = 0; i < _selectImgArray.count; i++) {
        BaseTabBarItem *item = [self.view viewWithTag:i + 100];
        
        if (i == self.selectedIndex) {
            item.isSelect = YES;
        }
        else
        {
            item.isSelect = NO;
        }
        
    }
    
    _selectView.frame = CGRectMake(self.selectedIndex * width + (width - 26) / 2, 5, 26, 26);
    _selectView.image = [UIImage imageNamed:_selectImgArray[item.tag - 100]];
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
