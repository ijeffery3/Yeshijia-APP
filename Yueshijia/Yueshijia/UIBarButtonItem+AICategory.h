//
//  UIBarButtonItem+AICategory.h
//  AimAPP
//
//  Created by CosyVan on 16/10/26.
//  Copyright © 2016年 Aimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AICategory)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action text:(NSString *)text textColor:(UIColor *)color;
@end
