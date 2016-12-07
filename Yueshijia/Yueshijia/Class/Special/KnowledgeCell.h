//
//  KnowledgeCell.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Knowledge;

@interface KnowledgeCell : UITableViewCell

@property (nonatomic, strong) Knowledge *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellHeight;

@end
