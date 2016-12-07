//
//  BasketGoodsCell.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/5.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BasketGoodsModel;

@protocol BasketGoodsCellDelegate <NSObject>

- (void)selectGoodsClick:(NSIndexPath *)indexPath btn:(UIButton *)btn;

@end

@interface BasketGoodsCell : UITableViewCell

@property (nonatomic, strong) BasketGoodsModel *model;
@property (nonatomic, weak) id<BasketGoodsCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end
