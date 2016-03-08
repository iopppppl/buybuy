//
//  BaseTabBarItem.m
//  买买买
//
//  Created by huiwen on 16/1/31.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "BaseTabBarItem.h"

@implementation BaseTabBarItem

{
    UILabel *titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 26) / 2, 5, 26, 26)];
        imgView.backgroundColor = [UIColor clearColor];
        imgView.image = [UIImage imageNamed:name];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:imgView];
        
        CGFloat maxY = CGRectGetMaxY(imgView.frame);
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, maxY, frame.size.width, 14)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self addSubview:titleLabel];
        
        self.selected = NO;
    }
    
    return self;
}

- (void)setIsSelect:(BOOL)isSelect
{
    if (_isSelect != isSelect) {
        _isSelect = isSelect;
        
        if (_isSelect) {
            titleLabel.textColor = [UIColor redColor];
        }
        else
        {
            titleLabel.textColor = [UIColor grayColor];
        }
        
    }
}


@end
