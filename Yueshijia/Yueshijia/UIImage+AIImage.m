//
//  UIImage+AIImage.m
//  iOS常用功能
//
//  Created by CosyVan on 2016/11/13.
//  Copyright © 2016年 Aimmy. All rights reserved.
//

#import "UIImage+AIImage.h"

@implementation UIImage (AIImage)
/*
 * 图片裁剪，适用于圆形头像之类
 */
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    // 图片的宽度和高度
    CGFloat imageWH = image.size.width;
    
    // 设置圆环的宽度
    CGFloat border = borderWidth;
    
    // 圆形的宽度和高度
    CGFloat ovalWH = imageWH + 2 * border;
    
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    // 2.画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [color set];
    
    [path fill];
    
    // 3.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clipPath addClip];
    
    // 4.绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    
    // 5.获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
    
}

/*
 * 截屏或者截取部分视图
 */
+ (UIImage *)imageWithCaptureView:(UIView *)captureView
{
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把控件上的图层渲染到上下文
    [captureView.layer renderInContext:ctx];
    
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return screenImage;

}

/*
 * 根据颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/*
 * 根据文字生成水印图片
 */
+ (UIImage *)imageWithWaterMarkImage:(NSString *)imageName text:(NSString *)str textRect:(CGRect)rect;

{
    UIImage *image = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //把图片画上去
    [image drawAtPoint:CGPointZero];
    
    //绘制文字到图片
    NSMutableDictionary *arrt = [NSMutableDictionary dictionary];
    arrt[NSFontAttributeName] = [UIFont systemFontOfSize:20.0];
    [str drawInRect:rect withAttributes:arrt];
    
    // 从上下文获取图片
    UIImage *imageWater = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return imageWater;
}

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)imageWithResizedImage:(NSString *)name capWidth:(CGFloat)width capHeight:(CGFloat)height;

{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:width topCapHeight:height];
}

/**
 * 改变图片大小缩放
 */
+ (UIImage *)imageWithOriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;  
}
@end
