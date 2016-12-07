//
//  ListTopViewController.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "ListTopViewController.h"
#import "ListTop.h"
#import "ListTopCell.h"
#import "GoodsDetailViewController.h"

@interface ListTopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *heights;

@property (nonatomic, strong) NSMutableArray *listTopArray;

@end



@implementation ListTopViewController

- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}

- (NSMutableArray *)listTopArray
{
    if (!_listTopArray) {
        _listTopArray = [NSMutableArray array];
    }
    return _listTopArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDatas];
    
    
    
    [self setupTableView];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40, ScreenWidth, ScreenHeight-64-40-44)];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 加载shuju
- (void)loadDatas
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"toplist" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *datas = [NSDictionary dictionary];
        datas = [json objectForKey:@"datas"];
        
        NSArray *articleList = datas[@"article_list"];
        for (NSDictionary *dict in articleList) {
            ListTop *model = [ListTop initWithDic:dict];
            [self.listTopArray addObject:model];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listTopArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTopCell *cell = [ListTopCell cellWithTableView:tableView];
    
    cell.model = self.listTopArray[indexPath.row];
    
    CGFloat tmpHeight = [cell cellHeight];
    
    
    [self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
    return cell;
}


// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
    vc.goodsDetailURL = @"http://interface.yueshichina.com//?act=cms_index&op=article_content&type_id=3&article_id=1064";
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self.heights[@(indexPath.row)] doubleValue];
}

@end
