//
//  StoreDetailViewController.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "StoreDetailModel.h"
#import "StoreDetailCell.h"

@interface StoreDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIImageView *picView;
@property (nonatomic, weak)  UILabel *textLabel;


@property (nonatomic, strong) NSMutableArray *cellArray;
/** 存放所有cell的高度 */
@property (strong, nonatomic) NSMutableDictionary *heights;

@end

@implementation StoreDetailViewController

#pragma mark - 懒加载
- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}

- (NSMutableArray *)cellArray
{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    //获取数据
    [self setupDatas];
    
    [self setupTableView];
    
}

- (void)setupNavBar
{
    UIBarButtonItem *basketBtn = [UIBarButtonItem itemWithTarget:self action:@selector(basketBtnClick) image:@"YS_car_sel" highImage:@"YS_car_sel"];
    
    UIBarButtonItem *shareBtn = [UIBarButtonItem itemWithTarget:self action:@selector(shareBtnClick) image:@"YSShare_end" highImage:@"YSShare_end"];
    
    self.navigationItem.rightBarButtonItems = @[shareBtn,basketBtn];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    UIView *headerView = ({
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 260)];
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
        self.picView = picView;
        [headerView addSubview:picView];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, ScreenWidth-20, 80)];
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont systemFontOfSize:13.0];
        textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel = textLabel;
        [headerView addSubview:textLabel];
        headerView;
    });
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - 获取数据
- (void)setupDatas
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"store_detailcell" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *datas = [jsonData objectForKey:@"datas"];
        NSString *title = datas[@"special_title"];
        
        self.title = title;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : ThemeColor};
        NSString *picURL = datas[@"special_image"];
        NSString *headText = datas[@"special_stitle"];
        [self.picView sd_setImageWithURL:[NSURL URLWithString:picURL]];
        self.textLabel.text = headText;
        
        NSArray *goodList = [NSArray array];
        goodList = datas[@"goods_list"];
       
        for (int i =0 ; i<goodList.count; i++) {
            NSDictionary *dict = goodList[i];
             NSLog(@"%@",dict);
            StoreDetailModel *model = [StoreDetailModel initWithDict:dict];
            [self.cellArray addObject:model];
        }
        
        //更新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
   
}

#pragma mark - 内部空间事件
- (void)basketBtnClick
{
    NSLog(@"--------basketBtnClick--------");
    [SVProgressHUD showSuccessWithStatus:@"点击购物篮"];
}

- (void)shareBtnClick
{
    NSLog(@"--------shareBenClick--------");
    NSString *textToShare = @"要分享的文本内容";
    UIImage *imageToShare = [UIImage imageNamed:@"zf1"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                            
                                                                            applicationActivities:nil];
    [self presentViewController:activityVC animated:true completion:nil];

}

#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreDetailCell *cell = [StoreDetailCell cellWithTableView:tableView];
    
    cell.model = self.cellArray[indexPath.row];
    // 获取高度
    CGFloat tmpHeight = [cell cellHeight];
    [self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
    return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self.heights[@(indexPath.row)] doubleValue];
}


@end
