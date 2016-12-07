//
//  TitleIconBtnModel.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleIconBtnModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, assign) NSInteger tag;

+ (instancetype)titleIconWith:(NSString *)title icon:(NSString *)image controller:(UIViewController *)controlller tag:(NSInteger )tag;
@end
