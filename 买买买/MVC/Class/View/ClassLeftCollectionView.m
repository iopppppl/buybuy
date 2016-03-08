//
//  ClassLeftCollectionView.m
//  买买买
//
//  Created by huiwen on 16/2/9.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "ClassLeftCollectionView.h"
#import "ClassLeftCollectionViewCell.h"
#import "ClassLeftCollectionReusableView.h"

#define identifyClass @"ClassCollectionViewCell"
#define identifyClassHeader @"ClassCollectionViewHeaderCell"

@implementation ClassLeftCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[ClassLeftCollectionViewCell class] forCellWithReuseIdentifier:identifyClass];
        
        [self registerClass:[ClassLeftCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifyClassHeader];
        
        
        
    }
    
    return self;
}

- (void)setModels:(NSMutableArray *)models
{
    if (_models != models) {
        _models = models;
        
        [self reloadData];
    }
    
    
}


#pragma mark - UICollectionView delegate
//1、指定组的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _models.count;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
//    for (int i = 0; i < _models.count; i++) {
//        if (section == i) {
//            
//            HomeModel *homeModel = _models[i];
//            
//            return homeModel.channels.count;
//        }
//    }
    
    HomeModel *homeModel = _models[section];
    
    return homeModel.channels.count;
    
//    return _models.count;
//        return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassLeftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifyClass forIndexPath:indexPath];
    HomeModel *model = _models[indexPath.section];
    
    HomeModel *homeModel = [[HomeModel alloc] initContentWithDic:model.channels[indexPath.row]];
    
    cell.homeModel = homeModel;
    
    return cell;
    
    
}

//- (UICollectionReusableView *)supplementaryViewForElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ClassLeftCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifyClassHeader forIndexPath:indexPath];

    headerView.backgroundColor = [UIColor whiteColor];
    
    HomeModel *homeModel = _models[indexPath.section];
    
    headerView.homeModel = homeModel;
    
    
    return headerView;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kScreenWidth / 4 - 5, kScreenWidth / 4 - 5 + 20);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionsViewController *collectionCtrl = [[CollectionsViewController alloc] init];
    HomeModel *model = _models[indexPath.section];
    
    NSMutableArray *arr = model.channels;
    
    NSDictionary *dic = arr[indexPath.row];
    
    HomeModel *homeModel = [[HomeModel alloc] initContentWithDic:dic];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts",homeModel.id];
    collectionCtrl.urlString = urlStr;
    
    [self.viewController.navigationController pushViewController:collectionCtrl animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
