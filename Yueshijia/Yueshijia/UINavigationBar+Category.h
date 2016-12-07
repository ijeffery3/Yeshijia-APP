//
//  UINavigationBar+Category.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/30.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Category)
/**
 *  自定义导航栏上的view
 */
@property (nonatomic,strong) UIView * alphaView;

/**
 *  给外界一个方法，来改变颜色
 */
-(void)alphaNavigationBarView:(UIColor *)color;
@end
