//
//  ClassLeftCollectionView.h
//  买买买
//
//  Created by huiwen on 16/2/9.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassLeftCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSArray *models;

@end
