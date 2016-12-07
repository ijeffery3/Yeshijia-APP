//
//  MapCell.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapModel;

@interface MapCell : UITableViewCell

@property (nonatomic, strong) MapModel *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellHeight;

@end
