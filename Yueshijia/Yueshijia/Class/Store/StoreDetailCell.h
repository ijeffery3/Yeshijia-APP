//
//  StoreDetailCell.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/29.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreDetailModel;

@interface StoreDetailCell : UITableViewCell

@property (nonatomic, strong) StoreDetailModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 * 返回这个cell的高度
 */
- (CGFloat)cellHeight;

@end
