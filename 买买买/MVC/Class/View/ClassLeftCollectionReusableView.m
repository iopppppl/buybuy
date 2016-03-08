//
//  ClassLeftCollectionReusableView.m
//  买买买
//
//  Created by huiwen on 16/2/10.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "ClassLeftCollectionReusableView.h"

@implementation ClassLeftCollectionReusableView
{
    UILabel *_titleLabel;
    UIView *_grayView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        _grayView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        [self addSubview:_grayView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:11];
        
        [self addSubview:_titleLabel];
    }
    
    return self;
    
}

- (void)setHomeModel:(HomeModel *)homeModel
{
    if (_homeModel != homeModel) {
        _homeModel = homeModel;
        
        [self configView];
    }
}

- (void)configView
{
    _titleLabel.text = _homeModel.name;
}

@end
