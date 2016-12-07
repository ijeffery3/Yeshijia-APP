//
//  HomeViewController.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "HomeViewController.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "shopCell.h"
#import "HomeThingCellModel.h"
#import "HomeThingCell.h"
#import "StoreDetailViewController.h"
#import "GoodsViewController.h"
#import "SearchViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIButton *upBtn;

@property (nonatomic, strong) NSMutableArray *tempArr;

@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, strong) NSString *infoPicName;

@property (nonatomic, strong) NSMutableArray *homeCellArray;
/** 存放所有cell的高度 */
@property (strong, nonatomic) NSMutableDictionary *heights;
/**
 *  缓存cell高度
 */
@property (nonatomic, strong) NSMutableArray *rowHeightArr;

@end



@implementation HomeViewController
- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleView];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"icon_home_search" highImage:@"icon_home_search_index"];
    
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

#pragma mark - 获取数据
- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Home" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",json);
        
        NSDictionary *datas = [NSDictionary dictionary];
        datas = [json objectForKey:@"datas"];
        NSMutableArray *bannerArr = [NSMutableArray array];
        bannerArr = [datas objectForKey:@"banner"];
        
        self.tempArr = [NSMutableArray array];
        for (int i =0 ; i<bannerArr.count; i++) {
            NSString *pic = [bannerArr[i] objectForKey:@"advertImg"];
            [self.tempArr addObject:pic];
        }
        
        NSMutableArray *data_type = [NSMutableArray array];
        data_type = [datas objectForKey:@"data_type"];
        self.homeCellArray = [NSMutableArray array];
        // 字典数组 -> 模型数组
        for (int i = 1; i<data_type.count; i++) {
                NSDictionary *dict = data_type[i];
                HomeThingCellModel *status = [HomeThingCellModel initWithDic:dict];
                [self.homeCellArray addObject:status];
           
        }
        
       
        
        NSDictionary *firstData = data_type[0];
        self.infoString = [firstData objectForKey:@"relation_object_title"];
        self.infoPicName = [firstData objectForKey:@"relation_object_image"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
   
}

#pragma mark - 内部私有方法
- (void)search
{
    NSLog(@"search----");
    [self.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
}

- (void)backTop
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (void)tapClicked
{
    [self.navigationController pushViewController:[[StoreDetailViewController alloc] init] animated:YES];
}

#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.homeCellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeThingCell *cell = [HomeThingCell cellWithTableView: tableView];
    
    cell.model = self.homeCellArray[indexPath.row];
    // 获取高度
    CGFloat tmpHeight = [cell cellHeight];
    
    
    [self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
    return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[GoodsViewController alloc] init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return [self.heights[@(indexPath.row)] doubleValue];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    
    DCPicScrollView  *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) WithImageUrls:self.tempArr];
    //占位图片,你可以在下载图片失败处修改占位图片
    [headerView addSubview:picView];
    picView.placeImage = [UIImage imageNamed:@"place.png"];
    
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {
        [self.navigationController pushViewController:[[StoreDetailViewController alloc] init] animated:YES];
    }];
    
    picView.AutoScrollDelay = 3.5f;
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 30)];
    label.text = @"YUESHI CHOSEN";
    label.textColor = RGB(231, 198, 168);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15.0];
    label.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:label];
    
    UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 230, ScreenWidth, 200)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [aImageView sd_setImageWithURL:[NSURL URLWithString:self.infoPicName]];
    });
    UIToolbar *burlView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    burlView.alpha = 0.8;
    [aImageView addSubview:burlView];
    UIImageView *bImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.2, 70, ScreenWidth * 0.6, 70)];
    bImageView.image = [UIImage imageNamed:@"InfoCelltitle"];
    [burlView addSubview:bImageView];
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake((bImageView.size.width-150)/2, 20, 150, 30)];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = self.infoString;
    infoLabel.font = [UIFont systemFontOfSize:17.0];
    [bImageView addSubview:infoLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
    [headerView addGestureRecognizer:tap];
    [headerView addSubview:aImageView];
    
    
    headerView.userInteractionEnabled = YES;
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(120, 200);
    //最小行间距
    layout.minimumLineSpacing = 15;
    //最小的item间距
    //    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat margin = 15;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 430, ScreenWidth, 220) collectionViewLayout:layout];
    collect.backgroundColor = [UIColor whiteColor];
    collect.userInteractionEnabled = YES;
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    //注册item类型
    [collect registerNib:[UINib nibWithNibName:NSStringFromClass([shopCell class]) bundle:nil] forCellWithReuseIdentifier:@"shopCell"];
    collect.scrollEnabled=YES;
    collect.showsHorizontalScrollIndicator = NO;
    [headerView addSubview:collect];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 650;
}


#pragma mark - scroll代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > ScreenHeight) {
        self.upBtn.hidden = NO;
    } else {
        self.upBtn.hidden = YES;
    }
}

#pragma mark - collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    shopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopCell" forIndexPath:indexPath];
    cell.userInteractionEnabled = YES;
    
    cell.pciName = @"icon_share_wx";
    cell.name = @"有问题加微信&QQ";
    cell.price = @"$ 879115636";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"点击了%ld行",indexPath.row]];
}


@end
