//
//  ClassRightCollectionViewCell.m
//  买买买
//
//  Created by huiwen on 16/2/10.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "ClassRightCollectionViewCell.h"

@implementation ClassRightCollectionViewCell
{
    UIImageView *_imageView;
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth / 4 - 5 - 30, kScreenWidth / 4 - 5 - 30)];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenWidth / 4 - 5, kScreenWidth / 4 - 5, 20)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:11];
        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_label];
        
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
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_homeModel.icon_url]];
    
    _label.text = _homeModel.name;
    
}
@end
