//
//  MainTabBarController.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "MainTabBarController.h"

#import "HomeViewController.h"
#import "SpecialViewController.h"
#import "BasketViewController.h"
#import "StoreViewController.h"
#import "MeViewController.h"
#import "MyTabBar.h"
#import "NavigationViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.title = @"首页";
    [self addChildVC:homeVC imageName:@"YS_index_nor" selectedImageName:@"YS_index_sel"];
    
    SpecialViewController *specialVC = [[SpecialViewController alloc] init];
    specialVC.title = @"专题";
    [self addChildVC:specialVC imageName:@"YS_pro_nor" selectedImageName:@"YS_pro_sel"];
    
    
    StoreViewController *storeVC = [[StoreViewController alloc] init];
    storeVC.title = @"店铺";
    [self addChildVC:storeVC imageName:@"YS_shop_nor" selectedImageName:@"YS_shop_sel"];
    
    BasketViewController *basketVC = [[BasketViewController alloc] init];
    basketVC.title = @"购物篮";
    [self addChildVC:basketVC imageName:@"YS_car_nor" selectedImageName:@"YS_car_sel"];
    
    
    MeViewController *meVC = [[MeViewController alloc] init];
    meVC.title = @"我";
    [self addChildVC:meVC imageName:@"YS_mine_nor" selectedImageName:@"YS_mine_sel"];
    
    MyTabBar *myTabBar = [[MyTabBar alloc] init];
    [self setValue:myTabBar forKey:@"tabBar"];
}

- (void)addChildVC:(UIViewController *)childVc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = RGB(168, 168, 168);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = RGB(211,192,162);
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 添加为tabbar控制器的子控制器
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}



@end
