//
//  ClassRightCollectionView.m
//  买买买
//
//  Created by huiwen on 16/2/10.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "ClassRightCollectionView.h"
#import "ClassRightCollectionViewCell.h"
#import "ClassRightCollectionReusableView.h"
#import "ClassViewController.h"
#import "ClassSearchViewController.h"

#define identifyClassRight @"ClassRightCollectionViewCell"
#define identifyClassHeaderRight @"ClassRightCollectionViewHeaderCell"

@implementation ClassRightCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[ClassRightCollectionViewCell class] forCellWithReuseIdentifier:identifyClassRight];
        
        [self registerClass:[ClassRightCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifyClassHeaderRight];
        
        
        
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
    
    HomeModel *homeModel = _models[section];
    
    return homeModel.subcategories.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifyClassRight forIndexPath:indexPath];
    HomeModel *model = _models[indexPath.section];
    
    HomeModel *homeModel = [[HomeModel alloc] initContentWithDic:model.subcategories[indexPath.row]];
    
    cell.homeModel = homeModel;
    
    return cell;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float y = self.contentOffset.y;
    
    float rY = 0;
    
    for (int i = 0; i < _models.count; i++) {
        
        HomeModel *model = _models[i];
        
        rY += ((model.subcategories.count - 1) / 3 + 1) * (kScreenWidth / 4 - 5 + 20) + 30;
        
        if (rY > y) {
            ClassViewController *VC = (ClassViewController *)self.viewController;
            
            [VC giftClassButtonActionTwo:400 + i];
            
            return;
        }
        
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ClassRightCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifyClassHeaderRight forIndexPath:indexPath];
    
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
    return CGSizeMake(kScreenWidth * 3 / 4, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ClassSearchViewController *classSearchCtrl = [[ClassSearchViewController alloc] init];
    HomeModel *model = _models[indexPath.section];
    
    NSMutableArray *arr = model.subcategories;
    
    NSDictionary *dic = arr[indexPath.row];
    
    HomeModel *homeModel = [[HomeModel alloc] initContentWithDic:dic];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/item_subcategories/%@/items",homeModel.id];
    classSearchCtrl.urlString = urlStr;
    classSearchCtrl.title = homeModel.name;
    
    [self.viewController.navigationController pushViewController:classSearchCtrl animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
