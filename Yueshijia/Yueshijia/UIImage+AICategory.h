//
//  UIImage+AICategory.h
//  AimAPP
//
//  Created by CosyVan on 16/10/21.
//  Copyright © 2016年 Aimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AICategory)
/**
 *  图片的压缩方法
 *
 *  @param sourceImg   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+ (UIImage *)IMGCompressed:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

/**
 *  根据颜色生成图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;
@end
