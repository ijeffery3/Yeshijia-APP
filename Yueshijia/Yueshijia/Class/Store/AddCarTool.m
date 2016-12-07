//
//  AddCarTool.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/6.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "AddCarTool.h"

@implementation AddCarTool

- (void)addView:(UIView *)moveView from:(CGPoint)start to:(CGPoint)end;
{
    self.moveView = moveView;
    /*
     首先根据传入的点画三次贝塞尔曲线
     画三次贝塞尔曲线的关键方法，以三个点画一段曲线，一般和moveToPoint:配合使用
     我这里偷懒了，可以传入4个点去画的更详细
     其组成是起始端点(moveToPoint:)+控制点1(controlPoint1:)+控制点2(controlPoint2:)+终止端点(addCurveToPoint:)
     */
    UIBezierPath *path= [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(start.x, start.y)];
    
    [path addCurveToPoint:CGPointMake(end.x, end.y)
            controlPoint1:CGPointMake(start.x, start.y)
            controlPoint2:CGPointMake(start.x - 50, start.y - 200)];
    
    //创建动画
    [self addAnimationWithPath:path];
}


#pragma mark - 创建动画
-(void)addAnimationWithPath:(UIBezierPath *)path
{
    //关键帧动画支持传入一套数值或一个路径来完成动画，先根据贝塞尔曲线创建一个关键帧动画确认动画路径
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //传入路径
    keyAnimation.path = path.CGPath;
    //设置动画速度设置
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    /*
     这是的动画速度的不同设置，可以尝试一下每个不同设置的区别
     kCAMediaTimingFunctionLinear 线性（匀速）
     kCAMediaTimingFunctionEaseIn 先慢
     kCAMediaTimingFunctionEaseOut 后慢
     kCAMediaTimingFunctionEaseInEaseOut 先慢 后慢 中间快
     kCAMediaTimingFunctionDefault 默认
     */
    
    //设置moveView的尺寸大小变化
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.5;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.4];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //设置moveView的旋转
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2];
    rotationAnimation.cumulative = YES;
    rotationAnimation.duration = 0.15;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    //创建一个动画组，把所有的动画都加入动画组同时执行
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[keyAnimation,rotationAnimation,scaleAnimation];
    groups.duration = 0.5;
    groups.removedOnCompletion = YES;
    groups.delegate = self;
    
    //添加动画到layer层
    [self.moveView.layer addAnimation:groups forKey:nil];
    
    /*在addAnimation:forKey:方法中，也可以给这个动画设置一个键，
     可以在其他地方将其取出来，进行一些操作，比如删除等。
     这也充分体现了kvc的灵活。*/
    /*
     可以根据不同的需求设置的KeyPath（好多我也没用过😝，如果有兴趣可以都试试）
     animationWithKeyPath的值：
     　         transform.scale = 比例转换
     transform.scale.x = 宽的比例转换
     transform.scale.y = 高的比例转换
     transform.rotation.z = 旋转
     opacity = 透明度
     backgroundColor = 背景颜色
     cornerRadius = 圆角
     margin = 间隔
     borderWidth = 边框宽度
     zPosition
     bounds
     contents
     contentsRect
     cornerRadius
     frame
     hidden
     mask
     masksToBounds
     opacity
     position
     shadowColor
     shadowOffset
     shadowOpacity
     shadowRadius
     */
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //在动画执行结束时移除移动的自定义view
    self.moveView = nil;
    //在动画执行结束时需要做的一些操作，例如让购物车缩放
    if (self.delegate && [self.delegate respondsToSelector:@selector(addCartFinished)]) {
        [self.delegate addCartFinished];
    }
}
@end
