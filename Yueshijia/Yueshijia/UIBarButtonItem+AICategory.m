//
//  UIBarButtonItem+AICategory.m
//  AimAPP
//
//  Created by CosyVan on 16/10/26.
//  Copyright © 2016年 Aimmy. All rights reserved.
//

#import "UIBarButtonItem+AICategory.h"

@implementation UIBarButtonItem (AICategory)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    /**
     *  设置返回barButton
     */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action text:(NSString *)text textColor:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setTitle:text forState:UIControlStateNormal];
    //设置尺寸
//    btn.size = btn.currentBackgroundImage.size;
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.size = CGSizeMake(44, 44);
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0] ];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
