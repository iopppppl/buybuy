//
//  BaseTabBarItem.h
//  买买买
//
//  Created by huiwen on 16/1/31.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarItem : UIControl

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name title:(NSString *)title;

@property (nonatomic,assign) BOOL isSelect;

@end
