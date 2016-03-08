//
//  GoodsDetailViewController.m
//  买买买
//
//  Created by huiwen on 16/2/4.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()

{
    UIScrollView *_scrollerView;
    UILabel *_nameLabel;
    UILabel *_priceLabel;
    UILabel *_descriptionLabel;
    UIPageControl *_pageCtrl;
    UIView *_buttomView;
}

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)setGoodID:(NSString *)goodID
{
    if (_goodID != goodID) {
        
        _goodID = goodID;
        
        [self requestOfGoods];
        
    }
}

- (void)requestOfGoods
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/items/%@",_goodID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //        NSLog(@"响应对象:%@", task.response);
        
        //responseObject是已经过JSON解析后的数据
        //                NSLog(@"%@", responseObject);
        
        NSDictionary *dicData = responseObject[@"data"];
        
        self.homeModel = [[HomeModel alloc] initContentWithDic:dicData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"errro:%@", error);
    }];
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
    [self _createScrollerView];
    [self _createLabel];
}

- (void)_createScrollerView
{
    
    NSString *firstStr = [_homeModel.image_urls firstObject];
    NSString *lastStr = [_homeModel.image_urls lastObject];
    
    [_homeModel.image_urls insertObject:lastStr atIndex:0];
    [_homeModel.image_urls addObject:firstStr];
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight - 64) * 3 / 5)];
    _scrollerView.delegate = self;
    _scrollerView.pagingEnabled = YES;
    _scrollerView.contentOffset = CGPointMake(kScreenWidth, 0);
    _scrollerView.bounces = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.showsVerticalScrollIndicator = NO;
//    _scrollerView.contentSize = CGSizeMake(kScreenWidth * _homeModel.image_urls.count, (kScreenHeight - 64) * 3 / 5);
    _scrollerView.contentSize = CGSizeMake(kScreenWidth * _homeModel.image_urls.count, -20);
    
    [self.view addSubview:_scrollerView];
    
    for (int i = 0; i < _homeModel.image_urls.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, (kScreenHeight - 64) * 3 / 5)];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_homeModel.image_urls[i]]];
        
        [_scrollerView addSubview:imageView];
    }
    
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, (kScreenHeight - 64) * 3 / 5 - 30, kScreenWidth, 30)];
    _pageCtrl.backgroundColor = [UIColor clearColor];
    _pageCtrl.numberOfPages = _homeModel.image_urls.count - 2;
    _pageCtrl.currentPage = 0;
    _pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
    [_pageCtrl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_pageCtrl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = _scrollerView.contentOffset.x / kScreenWidth - 1;
    
    if (page == _homeModel.image_urls.count - 2) {
        page = 0;
    }
    else if (page == -1)
    {
        page = _homeModel.image_urls.count - 3;
    }
    
    _pageCtrl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = _scrollerView.contentOffset.x / kScreenWidth - 1;
    
    if (page == _homeModel.image_urls.count - 2) {
        page = 0;
    }
    else if (page == -1)
    {
        page = _homeModel.image_urls.count - 3;
    }
    
    _pageCtrl.currentPage = page;
    
    _scrollerView.contentOffset = CGPointMake((page + 1) * kScreenWidth, _scrollerView.contentOffset.y);
    
}

- (void)changePage
{
    _scrollerView.contentOffset = CGPointMake((_pageCtrl.currentPage + 1) * kScreenWidth, _scrollerView.contentOffset.y);
}

- (void)_createLabel
{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (kScreenHeight - 64) * 3 / 5, kScreenWidth - 20, (kScreenHeight - 64) / 15)];
    _nameLabel.text = _homeModel.name;
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (kScreenHeight - 64) * 2 / 3, kScreenWidth - 20, (kScreenHeight - 64) / 15)];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[_homeModel.price floatValue]];
    
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (kScreenHeight - 64) * 11 / 15, kScreenWidth - 20, (kScreenHeight - 64) * 2 / 15)];
    
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.text = _homeModel.descriptions;
    
    _buttomView = [[UIView alloc] initWithFrame:CGRectMake(10, kScreenHeight - 64 - 30, kScreenWidth - 20, 30)];
    
    UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, (kScreenWidth - 20) / 2, 30)];
    detailButton.backgroundColor = [UIColor redColor];
    [detailButton addTarget:self action:@selector(detailButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [detailButton setTitle:@"网页详情" forState:UIControlStateNormal];
    [_buttomView addSubview:detailButton];
    
    UIButton *buyButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 0, (kScreenWidth - 20) / 2, 30)];
    buyButton.backgroundColor = [UIColor redColor];
    [buyButton addTarget:self action:@selector(buyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [buyButton setTitle:@"买买买" forState:UIControlStateNormal];
    [_buttomView addSubview:buyButton];
    
    
    [self.view addSubview:_nameLabel];
    [self.view addSubview:_priceLabel];
    [self.view addSubview:_descriptionLabel];
    [self.view addSubview:_buttomView];
    
}

- (void)detailButtonAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_homeModel.url]];
}

- (void)buyButtonAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_homeModel.purchase_url]];
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
