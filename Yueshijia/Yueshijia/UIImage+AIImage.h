//
//  UIImage+AIImage.h
//  iOS常用功能
//
//  Created by CosyVan on 2016/11/13.
//  Copyright © 2016年 Aimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AIImage)

/*
 * 图片裁剪，适用于圆形头像之类
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

/*
 * 截屏或者截取部分视图
 */
+ (UIImage *)imageWithCaptureView:(UIView *)captureView;

/*
 * 根据颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*
 * 根据文字生成水印图片
 * rect 是相对图片大小的位置
 */
+ (UIImage *)imageWithWaterMarkImage:(NSString *)imageName text:(NSString *)str textRect:(CGRect)rect;
/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)imageWithResizedImage:(NSString *)name capWidth:(CGFloat)width capHeight:(CGFloat)height;

/**
 * 改变图片大小缩放
 */
+ (UIImage *)imageWithOriginImage:(UIImage *)image scaleToSize:(CGSize)size;
@end
