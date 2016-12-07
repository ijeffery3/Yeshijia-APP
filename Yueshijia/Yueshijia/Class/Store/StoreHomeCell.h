//
//  StoreHomeCell.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/30.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_CollectionViewCell @"GridListCollectionViewCell"

@class StoreHomeModel;

@interface StoreHomeCell : UICollectionViewCell

/**
 0：列表视图，1：格子视图
 */
@property (nonatomic, assign) BOOL isGrid;

@property (nonatomic, strong) StoreHomeModel *model;

@end
