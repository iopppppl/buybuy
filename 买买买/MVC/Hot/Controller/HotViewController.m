//
//  HotViewController.m
//  买买买
//
//  Created by huiwen on 16/1/31.
//  Copyright © 2016年 hxc. All rights reserved.
//

#import "HotViewController.h"

@interface HotViewController ()

{
    HotCollectionView *_collectionView;
    NSMutableArray *_arrCollectionView;
}

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestOfCollectionView];
    
}

- (void)requestOfCollectionView
{
    _arrCollectionView = [[NSMutableArray alloc] init];
    
    NSString *urlString = @"http://api.liwushuo.com/v2/items";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    NSDictionary *params = @{
                             @"limit" :@20,
                             @"offset" :@0,
                             @"gender" :@1,
                             @"generation" :@2
                             };
    
    [manager GET:urlString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //        NSLog(@"响应对象:%@", task.response);
        
        //responseObject是已经过JSON解析后的数据
//                NSLog(@"%@", responseObject);
        
        NSDictionary *dicData = responseObject[@"data"];
        NSArray *arrBanners = dicData[@"items"];
        
        for (NSDictionary *dic in arrBanners) {
            
            NSDictionary *dicDataOfItem = dic[@"data"];
            
            HomeModel *homeModel = [[HomeModel alloc] initContentWithDic:dicDataOfItem];
            [_arrCollectionView addObject:homeModel];
        }
        
        [self _createCollectionView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"errro:%@", error);
    }];
}

- (void)_createCollectionView
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 10);
    
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    
    _collectionView = [[HotCollectionView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, kScreenHeight - 64 - 49) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.models = _arrCollectionView;
    
    [self.view addSubview:_collectionView];
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
