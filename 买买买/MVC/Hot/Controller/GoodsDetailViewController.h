//
//  GoodsDetailViewController.h
//  买买买
//
//  Created by huiwen on 16/2/4.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "SecondViewController.h"

@interface GoodsDetailViewController : SecondViewController <UIScrollViewDelegate>


@property(nonatomic,copy)NSString *goodID;
@property(nonatomic,strong)HomeModel *homeModel;

@end
