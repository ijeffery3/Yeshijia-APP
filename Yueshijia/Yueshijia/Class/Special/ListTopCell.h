//
//  ListTopCell.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListTop;

@interface ListTopCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellHeight;

@property (nonatomic, strong) ListTop *model;

@end
