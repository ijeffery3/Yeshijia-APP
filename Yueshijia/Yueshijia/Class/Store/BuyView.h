//
//  BuyView.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/4.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyViewDelegate <NSObject>

- (void)doneButtonClick:(NSInteger)goodsNum;
- (void)closeView;

@end

@interface BuyView : UIView

@property (nonatomic, weak) id<BuyViewDelegate> delegate;

@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *goodsPicName;
@property (nonatomic, strong) NSString *goodsPrice;
@property (nonatomic, strong) NSString *goodsOrigPrice;


@property (nonatomic, weak) UIImageView *picImageView;

@end
