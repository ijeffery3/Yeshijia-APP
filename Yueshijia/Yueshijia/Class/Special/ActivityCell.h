//
//  ActivityCell.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityModel;


@interface ActivityCell : UITableViewCell

@property (nonatomic, strong) ActivityModel *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellHeight;

@end
