//
//  MeViewController.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "MeViewController.h"
#import "UIImage+AIImage.h"

#import "MeOrderCell.h"
#import "MeAccountCell.h"

#define HeadViewH 200
#define HeadViewMinH 64

#define kIconW 60
#define kIconH 60
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIImageView *iconImage;

// 顶部的照片
@property (nonatomic, strong) UIImageView *topImageView;
// 毛玻璃
@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, weak) UILabel *userLabel;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
    [self setupSettingBtn];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - 界面初始化
// tableView
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.tableFooterView = [UIView new];
    
    
    self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -HeadViewH, self.view.frame.size.width, HeadViewH))];
    _topImageView.image = [UIImage imageNamed:@"wishbg.jpg"];

    _topImageView.contentMode = UIViewContentModeScaleAspectFill;

    _topImageView.clipsToBounds = YES;
    [self.tableView addSubview:self.topImageView];
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageWithClipImage:[UIImage imageNamed:@"icon_share_wx.png"] borderWidth:2 borderColor:[UIColor whiteColor]];
    self.iconImage = iconImage;
    [_topImageView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_topImageView.mas_centerX);
        make.centerY.mas_equalTo(_topImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kIconH, kIconH));
    }];
    
    UILabel *userLabel = [[UILabel alloc] init];
    userLabel.text = @"jeffery";
    userLabel.font = [UIFont systemFontOfSize:18.0];
    userLabel.textColor = [UIColor whiteColor];
    userLabel.textAlignment = NSTextAlignmentCenter;
    self.userLabel = userLabel;
    [_topImageView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImage.mas_bottom).offset(18);
        make.centerX.mas_equalTo(iconImage.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 21));
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(HeadViewH, 0, 0, 0);
    
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
//    effectView.frame = _topImageView.frame;
//    _effectView = effectView;
//    [self.tableView addSubview:_effectView];
    

    
}

- (void)setupSettingBtn
{
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    //设置尺寸
    settingBtn.size = settingBtn.currentBackgroundImage.size;
    [self.view addSubview:settingBtn];
    
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(25);
        make.left.mas_equalTo(self.view).offset(15);
    }];
}


#pragma mark - TableView代理方法
// tableView数据源代理方法啊
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }

    if (indexPath.row == 0) {
        MeOrderCell *cell = [MeOrderCell cellWithTableView:tableView];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, MAXFLOAT)];
        return cell;
    } else if (indexPath.row == 1) {
        MeAccountCell *cell = [MeAccountCell cellWithTableView:tableView];
        
        return cell;
    } else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"我的收藏";
    }
    else if (indexPath.row == 3) {
        
        cell.textLabel.text = @"我的活动";
    }
    else if (indexPath.row == 4) {
        
        cell.textLabel.text = @"邀请好友";
    }
    else if (indexPath.row == 5) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = @"联系客服(9:00-18:00)";
        cell.detailTextLabel.text = @"4006-277-717";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
   
    
}



// tableView代理方法啊
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    } else if (indexPath.row == 1) {
        return 150;
    } else  {
        return 44;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 向下的话 为负数
    CGFloat offY = scrollView.contentOffset.y;
    
    // 下拉超过照片的高度的时候
    if (offY < - HeadViewH)
    {
        CGRect frame = self.topImageView.frame;
        // 这里的思路就是改变 顶部的照片的 fram
        self.topImageView.frame = CGRectMake(0, offY, frame.size.width, -offY);
//        self.effectView.frame = self.topImageView.frame;
        // 对应调整毛玻璃的效果
//        self.effectView.alpha = 1 + (off_y + HeadViewH) / ScreenHeight ;
    }
    
    
    
}


@end
