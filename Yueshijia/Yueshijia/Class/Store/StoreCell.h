//
//  StoreCell.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreModel;

@interface StoreCell : UITableViewCell

@property (nonatomic, strong) StoreModel *models;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 * 返回这个cell的高度
 */
- (CGFloat)cellHeight;

@end
