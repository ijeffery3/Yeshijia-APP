//
//  SpecialViewController.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "SpecialViewController.h"
#import "VideoViewController.h"
#import "ListTopViewController.h"
#import "KnowledgeViewController.h"
#import "HumanismViewController.h"
#import "MapViewController.h"
#import "ActivityViewController.h"



CGFloat const TitilesViewH = 44;

@interface SpecialViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
@end


@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleView];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"icon_home_search" highImage:@"icon_home_search_index"];
    
    [self setupChildVces];
    
    [self setupTitlesView];
    [self setupContentView];
    
}

- (void)setTitleView
{
    UIImageView *titleImage = [[UIImageView alloc] init];
    titleImage.frame = CGRectMake(20, 20, 60, 20);
    titleImage.image = [UIImage imageNamed:@"YS_food+"];
    self.navigationItem.titleView = titleImage;
}

#pragma mark - 创建滑动视图
- (void)setupChildVces
{
    VideoViewController *v1 = [[VideoViewController alloc] init];
    v1.title = @"视频";
    [self addChildViewController:v1];
    ListTopViewController *v2 = [[ListTopViewController alloc] init];
    v2.title = @"榜单";
//    v2.view.backgroundColor = RandomColor;
    [self addChildViewController:v2];
    KnowledgeViewController *v3 = [[KnowledgeViewController alloc] init];
    v3.title = @"知识";
//    v3.view.backgroundColor = RandomColor;
    [self addChildViewController:v3];
    KnowledgeViewController *v4 = [[KnowledgeViewController alloc] init];
    v4.title = @"人文";
//    v4.view.backgroundColor = RandomColor;
    [self addChildViewController:v4];
    MapViewController *v5 = [[MapViewController alloc] init];
    v5.title = @"地图";
//    v5.view.backgroundColor = RandomColor;
    [self addChildViewController:v5];
    ActivityViewController *v6 = [[ActivityViewController alloc] init];
    v6.title = @"活动";
//    v6.view.backgroundColor = RandomColor;
    [self addChildViewController:v6];
}

- (void)setupTitlesView
{
    //标签栏整体
    UIView *titlesView =  [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    titlesView.width = self.view.width;
    titlesView.height = TitilesViewH;
    titlesView.y = 64;
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
    
    //下面的指示器view
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = ThemeColor;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部子视图空间
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height + 2;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:ThemeColor forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    //底部灰色背景
    UIView *indicatorBgView = [[UIView alloc] init];
    indicatorBgView.backgroundColor = RGB(250, 250, 250);
    indicatorBgView.width = self.view.width;
    indicatorBgView.height = 2;
    indicatorBgView.y = TitilesViewH - 2;
    [self.titlesView addSubview:indicatorBgView];

    
    [titlesView addSubview:indicatorView];
}


- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = ScreenWidth/self.childViewControllers.count;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}



#pragma mark - 内部私有方法
- (void)search
{
    NSLog(@"search----");
    [SVProgressHUD showSuccessWithStatus:@"搜索"];
}

@end
