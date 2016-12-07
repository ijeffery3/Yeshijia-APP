//
//  StoreViewController.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreDetailViewController.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "AITitleIconView.h"
#import "TitleIconBtnModel.h"
#import "AIMenuView.h"
#import "XsyhView.h"
#import "StoreModel.h"
#import "StoreCell.h"
#import "XsView.h"

@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,AIMenuViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIButton *upBtn;

@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *menuArray;

@property (nonatomic, strong) NSMutableArray *storeCellArray;

@property (nonatomic, strong) NSDictionary *channelDict;


@property (strong, nonatomic) NSMutableDictionary *heights;


@end

@implementation StoreViewController

- (NSDictionary *)channelDict
{
    if (!_channelDict) {
        _channelDict = [NSDictionary dictionary];
    }
    
    return _channelDict;
}

- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}

- (NSMutableArray *)menuArray
{
    if (!_menuArray) {
        _menuArray = [NSMutableArray array];
    }
    return _menuArray;
}

- (NSMutableArray *)storeCellArray
{
    if (!_storeCellArray) {
        _storeCellArray = [NSMutableArray array];
    }
    return _storeCellArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleView];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"icon_home_search" highImage:@"icon_home_search_index"];
    
    [self setupData];
    
    [self setupTableView];
    [self setUpBtn];
    
    
    
    
}

- (void)setTitleView
{
    UIImageView *titleImage = [[UIImageView alloc] init];
    titleImage.frame = CGRectMake(20, 20, 60, 20);
    titleImage.image = [UIImage imageNamed:@"YS_food+"];
    self.navigationItem.titleView = titleImage;
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)setUpBtn
{
    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upBtn.frame = CGRectMake(ScreenWidth - 70, ScreenHeight * 0.8, 44, 44);
    [upBtn setBackgroundImage:[UIImage imageNamed:@"icon_back_top"] forState:UIControlStateNormal];
    upBtn.hidden = YES;
    [upBtn addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
    self.upBtn = upBtn;
    [self.view addSubview:upBtn];
}


- (void)setupData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Store" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *datas = [NSDictionary dictionary];
        datas = [json objectForKey:@"datas"];
        
        self.channelDict = [datas objectForKey:@"channel"];
        
        NSMutableArray *bannerArr = [NSMutableArray array];
        bannerArr = [datas objectForKey:@"banner"];
        
        self.bannerArray = [NSMutableArray array];
        for (int i =0 ; i<bannerArr.count; i++) {
            NSString *pic = [bannerArr[i] objectForKey:@"advertImg"];
            [self.bannerArray addObject:pic];
        }
        
        NSArray *menuArr = [NSArray array];
        menuArr = [datas objectForKey:@"tag_classify"];
        
        for (int i =0 ; i<menuArr.count; i++) {
             NSDictionary *dict = menuArr[i];
            
            TitleIconBtnModel *btnModel = [TitleIconBtnModel titleIconWith:[dict objectForKey:@"tag_name"] icon:[dict objectForKey:@"tag_img"] controller:self tag:[[dict objectForKey:@"tag_type"] intValue]];
            [self.menuArray addObject:btnModel];
        }
        
        
        
        NSMutableArray *query = [NSMutableArray array];
        query = [datas objectForKey:@"query"];
        self.storeCellArray = [NSMutableArray array];
        // 字典数组 -> 模型数组
        for (int i = 1; i<query.count; i++) {
            NSDictionary *dict = query[i];
            StoreModel *m = [StoreModel initWithDic:dict];
            [self.storeCellArray addObject:m];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

#pragma mark - 内部私有方法
- (void)search
{
    NSLog(@"search----");
    [SVProgressHUD showSuccessWithStatus:@"search"];
}

- (void)backTop
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}
#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.storeCellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreCell *cell = [StoreCell cellWithTableView: tableView];
    
    cell.models = self.storeCellArray[indexPath.row];
    // 获取高度
    CGFloat tmpHeight = [cell cellHeight];
    
    
    [self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
    return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreDetailViewController *storeDetailVC = [[StoreDetailViewController alloc] init];
    
    [self.navigationController pushViewController:storeDetailVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self.heights[@(indexPath.row)] doubleValue];
}

/**
 *  调用这个方法之后,会先执行cellForRowAtIndexPath而不是heightForRowAtIndexPath
 */
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 420;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    
    DCPicScrollView  *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) WithImageUrls:self.bannerArray];
    //占位图片,你可以在下载图片失败处修改占位图片
    [headerView addSubview:picView];
    picView.placeImage = [UIImage imageNamed:@"place.png"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("第%zd张图片\n",index);
    }];
    
    picView.AutoScrollDelay = 3.5f;
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
    
    AIMenuView *menuView = [[AIMenuView alloc]initMenu:self.menuArray];
    menuView.delegate = self;
    menuView.frame = CGRectMake(0, 200, ScreenWidth, 180);
    [headerView addSubview:menuView];
    
    XsView *xsView = [[XsView alloc] initWithFrame:CGRectMake(0, 380, ScreenWidth, 200)];
    xsView.bgImageName = [self.channelDict objectForKey:@"goods_img"];
    
    xsView.title = [self.channelDict objectForKey:@"title"];
    xsView.nowPrice = [self.channelDict objectForKey:@"zhekou"];
    xsView.origPrice = [self.channelDict objectForKey:@"goods_price"];
    xsView.desc = [self.channelDict objectForKey:@"goods_name"];
    [headerView addSubview:xsView];
    
    
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 580;
}


#pragma mark -
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > ScreenHeight) {
        self.upBtn.hidden = NO;
    } else {
        self.upBtn.hidden = YES;
    }
}

#pragma mark - AIMenuDelegate
- (void)menuBtnClick
{
    NSLog(@"-----------");
    [SVProgressHUD showSuccessWithStatus:@"menuBtnClick"];
}

@end
