//
//  XsyhView.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XsyhView : UIView

@property (nonatomic, strong) NSString *bgImageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *nowPrice;
@property (nonatomic, strong) NSString *origPrice;
@property (nonatomic, strong) NSString *desc;

+ (XsyhView *)initXshyView;

@end
