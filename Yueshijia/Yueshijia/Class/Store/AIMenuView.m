//
//  AIMenuView.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "AIMenuView.h"
#import "AITitleIconView.h"

@interface AIMenuView ()
@property (nonatomic, strong) NSArray *menuArray;
@end

@implementation AIMenuView

static const NSInteger DefaultRowNumbers = 4;

- (instancetype)initMenu:(NSArray<TitleIconBtnModel *> *)menuArray
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.menuArray = menuArray;
        for (TitleIconBtnModel *title in menuArray) {
            AITitleIconView * titleIconView = [[AITitleIconView alloc] initWithTitleLabel:title.title icon:title.icon boder:NO];
            titleIconView.tag = title.tag;
            titleIconView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleIconViewClick)];
            [titleIconView addGestureRecognizer:tap];
            [self addSubview:titleIconView];
        }
    }
     return self;
}

- (void)titleIconViewClick
{
    if ([self.delegate respondsToSelector:@selector(menuBtnClick)]) {
        [self.delegate menuBtnClick];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = ScreenWidth / DefaultRowNumbers;
//    CGFloat height = ScreenHeight / (self.menuArray.count / DefaultRowNumbers);
    CGFloat height = 90;
    NSLog(@"%f",height);
    for (int i = 0; i<self.subviews.count; i++) {
        AITitleIconView *titleIconView = self.subviews[i];
        CGFloat viewX = (i % DefaultRowNumbers) *width;
        CGFloat viewY = (i / DefaultRowNumbers) * height;
        
        titleIconView.frame = CGRectMake(viewX, viewY, width, height);
    }
}

@end
