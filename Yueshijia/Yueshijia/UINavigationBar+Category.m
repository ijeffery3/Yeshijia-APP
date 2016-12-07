//
//  UINavigationBar+Category.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/30.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "UINavigationBar+Category.h"
#import <objc/runtime.h>


@implementation UINavigationBar (Category)

static char alView;

/**
 *  set方法
 */
-(void)setAlphaView:(UIView *)alphaView{
    objc_setAssociatedObject(self, &alView, alphaView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/**
 *  get方法
 */
-(UIView *)alphaView{
    return objc_getAssociatedObject(self, &alView);
}

-(void)alphaNavigationBarView:(UIColor *)color{
    if (!self.alphaView) {
        //设置背景图片
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //创建
        self.alphaView = [[UIView alloc ]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        //插入到navigationbar
        
        [self insertSubview:self.alphaView atIndex:0];
        
    }
    
    [self.alphaView setBackgroundColor:color];
}

@end
