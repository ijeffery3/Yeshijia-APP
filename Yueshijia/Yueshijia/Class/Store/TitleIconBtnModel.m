//
//  TitleIconBtnModel.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "TitleIconBtnModel.h"

@implementation TitleIconBtnModel

+ (instancetype)titleIconWith:(NSString *)title icon:(NSString *)image controller:(UIViewController *)controlller tag:(NSInteger )tag{
    TitleIconBtnModel *titleIconAction = [[TitleIconBtnModel alloc]init];
    titleIconAction.title = title;
    titleIconAction.icon = image;
    titleIconAction.controller = controlller;
    titleIconAction.tag = tag;
    return titleIconAction;
}

@end
