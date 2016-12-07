//
//  AIMenuView.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleIconBtnModel.h"

@protocol  AIMenuViewDelegate<NSObject>

- (void)menuBtnClick;

@end

@interface AIMenuView : UIView

@property (nonatomic, weak) id<AIMenuViewDelegate> delegate;

- (instancetype)initMenu:(NSArray <TitleIconBtnModel *> *)menuArray;

@end
