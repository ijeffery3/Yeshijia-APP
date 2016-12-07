//
//  HomeThingCell.h
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeThingCellModel;

@interface HomeThingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) HomeThingCellModel *model;

- (CGFloat)cellHeight;
@end
