//
//  ClassViewController.m
//  买买买
//
//  Created by huiwen on 16/1/31.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "ClassViewController.h"
#import "TypeSearchViewController.h"
#import "TextSearchViewController.h"

@interface ClassViewController ()

{
    UIButton *_tacticButton;
    UIButton *_giftButton;
    
    UIScrollView *_backgroundScrollerView;
    
    NSMutableArray *_arrTacticCollectionView;
    NSMutableArray *_arrGiftCollectionView;
    
    
    ClassLeftCollectionView *_leftCollectionView;
    ClassRightCollectionView *_rightCollectionView;
    
    UIScrollView *_giftClassScrollerView;
    
    UIView *_selectView;
    
    UIView *_buttonView;
    
    UIButton *_selectGiftButton;
    
    UIButton *_searchButton;
    
}

@end

@implementation ClassViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _buttonView.hidden = YES;
    _selectGiftButton.hidden = YES;
    
    _searchButton.hidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    _buttonView.hidden = NO;
    _selectGiftButton.hidden = NO;
    
    _searchButton.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createUI];
    
}

- (void)_createUI
{
    [self _createNavBarButton];
    [self _createBackgroundScrollerView];
    [self requestOfTacticScrollerView];
    [self requestOfGiftScrollerView];
}

#pragma mark ---导航栏上的button

- (void)_createNavBarButton
{
    _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 10, 25, 25)];
    [_searchButton setBackgroundImage:[UIImage imageNamed:@"Search_fruitless@2x"] forState:UIControlStateNormal];
    [_searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:_searchButton];
    
    _buttonView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 4, 10, kScreenWidth / 2, 24)];
    _buttonView.tag = 302;
    _buttonView.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar addSubview:_buttonView];
    
    _tacticButton = [[UIButton alloc] initWithFrame:CGRectMake(1, 1, kScreenWidth / 4 - 1, 22)];
    _tacticButton.tag = 300;
    [_tacticButton setTitle:@"攻略" forState:UIControlStateNormal];
    _tacticButton.backgroundColor = [UIColor whiteColor];
    [_tacticButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _tacticButton.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    [_tacticButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:_tacticButton];
    
    _giftButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 4, 1, kScreenWidth / 4 - 1, 22)];
    _giftButton.tag = 301;
    [_giftButton setTitle:@"礼物" forState:UIControlStateNormal];
    _giftButton.backgroundColor = [UIColor redColor];
    [_giftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _giftButton.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    [_giftButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView addSubview:_giftButton];
    
//    UISegmentedControl *segCtrl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2, 30)];
//    segCtrl.backgroundColor = [UIColor redColor];
//    segCtrl.selectedSegmentIndex = 0;
//    
//    [segCtrl insertSegmentWithTitle:@"攻略" atIndex:0 animated:YES];
//    [segCtrl insertSegmentWithTitle:@"礼物" atIndex:1 animated:YES];
////    [segCtrl setTitle:@"sda" forSegmentAtIndex:0];
//    
//    [buttonView addSubview:segCtrl];
    
    _selectGiftButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 7, 60, 30)];
    [_selectGiftButton addTarget:self action:@selector(selectGiftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_selectGiftButton setTitle:@"选礼神器" forState:UIControlStateNormal];
    _selectGiftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.navigationController.navigationBar addSubview:_selectGiftButton];
    
}

- (void)searchButtonAction:(UIButton *)button
{
    TextSearchViewController *textSearchVC = [[TextSearchViewController alloc] init];
    textSearchVC.urlString = @"http://api.liwushuo.com/v2/search/hot_words";
    
    [self.navigationController pushViewController:textSearchVC animated:YES];
}

- (void)selectGiftButtonAction:(UIButton *)button
{
    TypeSearchViewController *typeSearchVC = [[TypeSearchViewController alloc] init];
    typeSearchVC.urlString = @"http://api.liwushuo.com/v2/search/item_by_type";
    typeSearchVC.title = @"挑选礼物";
    
    [self.navigationController pushViewController:typeSearchVC animated:YES];
    
}

- (void)selectTacticButton
{
    _tacticButton.backgroundColor = [UIColor whiteColor];
    [_tacticButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _giftButton.backgroundColor = [UIColor redColor];
    [_giftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.4 animations:^{
        _backgroundScrollerView.contentOffset = CGPointMake(0, _backgroundScrollerView.contentOffset.y);
    }];
    
}

- (void)selectGiftButton
{
    _tacticButton.backgroundColor = [UIColor redColor];
    [_tacticButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _giftButton.backgroundColor = [UIColor whiteColor];
    [_giftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.4 animations:^{
        _backgroundScrollerView.contentOffset = CGPointMake(kScreenWidth, _backgroundScrollerView.contentOffset.y);
    }];
    
}

- (void)topButtonAction:(UIButton *)button
{
    
    if (button.tag == 300)
    {
        
        [self selectTacticButton];
        
    }
    else if (button.tag == 301)
    {
        
        [self selectGiftButton];
        
    }
    
}


#pragma mark ---背景scrollerView

- (void)_createBackgroundScrollerView
{
    _backgroundScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 -49)];
    _backgroundScrollerView.contentSize = CGSizeMake(kScreenWidth * 2, -20);
    _backgroundScrollerView.delegate = self;
    _backgroundScrollerView.bounces = NO;
    _backgroundScrollerView.pagingEnabled = YES;
    _backgroundScrollerView.showsHorizontalScrollIndicator = NO;
    _backgroundScrollerView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_backgroundScrollerView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_backgroundScrollerView.contentOffset.x > kScreenWidth / 2)
    {
        [self selectGiftButton];
    }
    else
    {
        [self selectTacticButton];
    }
    
}

#pragma mark ---左边攻略scrollerView



- (void)requestOfTacticScrollerView
{
    _arrTacticCollectionView = [[NSMutableArray alloc] init];
    
    NSString *urlString = @"http://api.liwushuo.com/v2/channel_groups/all";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
//    NSDictionary *params = @{
//                             @"limit" :@20,
//                             @"offset" :@0,
//                             @"gender" :@1,
//                             @"generation" :@2
//                             };
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //        NSLog(@"响应对象:%@", task.response);
        
        //responseObject是已经过JSON解析后的数据
        //                NSLog(@"%@", responseObject);
        
        NSDictionary *dicData = responseObject[@"data"];
        NSArray *arrChannel = dicData[@"channel_groups"];
        
        for (NSDictionary *dic in arrChannel) {
            
//            NSDictionary *dicDataOfItem = dic[@"data"];
            
            HomeModel *homeModel = [[HomeModel alloc] initContentWithDic:dic];
            [_arrTacticCollectionView addObject:homeModel];
        }
        
        [self _createTacticCollectionView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"errro:%@", error);
    }];
}

- (void)_createTacticCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 20);
    
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _leftCollectionView = [[ClassLeftCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) collectionViewLayout:flowLayout];
    _leftCollectionView.backgroundColor = [UIColor whiteColor];
    _leftCollectionView.models = _arrTacticCollectionView;
    
    [_backgroundScrollerView addSubview:_leftCollectionView];
}


#pragma mark ---右边礼物scrollerView

- (void)requestOfGiftScrollerView
{
    _arrGiftCollectionView = [[NSMutableArray alloc] init];
    
    
    NSString *urlString = @"http://api.liwushuo.com/v2/item_categories/tree";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    //    NSDictionary *params = @{
    //                             @"limit" :@20,
    //                             @"offset" :@0,
    //                             @"gender" :@1,
    //                             @"generation" :@2
    //                             };
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //        NSLog(@"响应对象:%@", task.response);
        
        //responseObject是已经过JSON解析后的数据
        //                NSLog(@"%@", responseObject);
        
        NSDictionary *dicData = responseObject[@"data"];
        NSArray *arrCategories = dicData[@"categories"];
        
        for (NSDictionary *dic in arrCategories) {
            
            //            NSDictionary *dicDataOfItem = dic[@"data"];
            
            HomeModel *homeModel = [[HomeModel alloc] initContentWithDic:dic];
            [_arrGiftCollectionView addObject:homeModel];
        }
        
        [self _createGiftCollectionView];
        [self _createGiftClassScrollerView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"errro:%@", error);
    }];
}

- (void)_createGiftCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 20);
    
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _rightCollectionView = [[ClassRightCollectionView alloc] initWithFrame:CGRectMake(kScreenWidth + kScreenWidth / 4, 0, kScreenWidth * 3 / 4, kScreenHeight - 64 - 49) collectionViewLayout:flowLayout];
    _rightCollectionView.backgroundColor = [UIColor whiteColor];
    _rightCollectionView.models = _arrGiftCollectionView;
    
    [_backgroundScrollerView addSubview:_rightCollectionView];
}

- (void)_createGiftClassScrollerView
{
    
    
    _giftClassScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth / 4, kScreenHeight - 64 - 49)];
    _giftClassScrollerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    _giftClassScrollerView.showsHorizontalScrollIndicator = NO;
    _giftClassScrollerView.showsVerticalScrollIndicator = NO;
    _giftClassScrollerView.bounces = NO;
    _giftClassScrollerView.contentSize = CGSizeMake(-20, _arrGiftCollectionView.count * 40);
    
    [_backgroundScrollerView addSubview:_giftClassScrollerView];
    
    for (int i = 0; i < _arrGiftCollectionView.count; i++) {
        
        HomeModel *homeModel = _arrGiftCollectionView[i];
        
        UIButton *giftClassButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 40 * i, kScreenWidth / 4, 40)];
        giftClassButton.tag = 400 + i;
        [giftClassButton setTitle:homeModel.name forState:UIControlStateNormal];
        
        [giftClassButton addTarget:self action:@selector(giftClassButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            giftClassButton.backgroundColor = [UIColor whiteColor];
            [giftClassButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
        }
        
        else
        {
            giftClassButton.backgroundColor = [UIColor clearColor];
            [giftClassButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        [_giftClassScrollerView addSubview:giftClassButton];
    }
    
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 40)];
    _selectView.backgroundColor = [UIColor redColor];
    
    [_giftClassScrollerView addSubview:_selectView];
    
    
    
}

- (void)giftClassButtonAction:(UIButton *)button
{
    
    for (int i = 0; i < _arrGiftCollectionView.count; i++) {
        
        UIButton *newButton = [self.view viewWithTag:400 + i];
        
        if (button.tag == 400 + i) {
            newButton.backgroundColor = [UIColor whiteColor];
            [newButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else
        {
            newButton.backgroundColor = [UIColor clearColor];
            [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
    }
    
    _selectView.frame = CGRectMake(0, 40 * (button.tag - 400), 3, 40);
    
    float y = 40 * (button.tag - 401);
    if (y < 0) {
        y = 0;
    }
    else if (y > _arrGiftCollectionView.count * 40 - (kScreenHeight - 64 - 49)) {
        y = _arrGiftCollectionView.count * 40 - (kScreenHeight - 64 - 49);
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _giftClassScrollerView.contentOffset = CGPointMake(_giftClassScrollerView.contentOffset.x, y);
    }];
    
    float maxY;
    for (int i = 0; i < _arrGiftCollectionView.count; i++) {
        
        HomeModel *model = _arrGiftCollectionView[i];
        
        if (model.subcategories.count > 0) {
            maxY += ((model.subcategories.count - 1) / 3 + 1) * (kScreenWidth / 4 - 5 + 20) + 30;
        }
        
    }
    
    float rY = 0;
    
    for (int i = 0; i < button.tag - 400; i++) {
        
        HomeModel *model = _arrGiftCollectionView[i];
        
        if (model.subcategories.count > 0) {
            rY += ((model.subcategories.count - 1) / 3 + 1) * (kScreenWidth / 4 - 5 + 20) + 30;
        }
        
        if (rY > maxY - (kScreenHeight - 64 - 49)) {
            rY = maxY - (kScreenHeight - 64 - 49);
        }
        
    }
    
    _rightCollectionView.contentOffset = CGPointMake(_rightCollectionView.contentOffset.x, rY);
    
}

- (void)giftClassButtonActionTwo:(NSInteger)tag
{
    
    for (int i = 0; i < _arrGiftCollectionView.count; i++) {
        
        UIButton *newButton = [self.view viewWithTag:400 + i];
        
        if (tag == 400 + i) {
            newButton.backgroundColor = [UIColor whiteColor];
            [newButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else
        {
            newButton.backgroundColor = [UIColor clearColor];
            [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
    }
    
    _selectView.frame = CGRectMake(0, 40 * (tag - 400), 3, 40);
    
    float y = 40 * (tag - 401);
    if (y < 0) {
        y = 0;
    }
    else if (y > _arrGiftCollectionView.count * 40 - (kScreenHeight - 64 - 49)) {
        y = _arrGiftCollectionView.count * 40 - (kScreenHeight - 64 - 49);
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _giftClassScrollerView.contentOffset = CGPointMake(_giftClassScrollerView.contentOffset.x, y);
    }];
    
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
