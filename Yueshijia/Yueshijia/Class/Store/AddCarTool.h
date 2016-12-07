//
//  AddCarTool.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/6.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol AddCartToolDelegate <NSObject>

/** 添加购物车结束的回调 */
- (void)addCartFinished;

@end

@interface AddCarTool : NSObject

/*需要移动的自定义view，这里是为了在添加动画和在结束时移除*/
@property (nonatomic, strong) UIView * moveView;

/**
 *  将自定义view从起点移动到终点
 *
 *  @param moveView   需要移动的自定义view
 *  @param start  起点的坐标
 *  @param end    终点的坐标
 */
- (void)addView:(UIView *)moveView from:(CGPoint)start to:(CGPoint)end;

@property (nonatomic, weak) id <AddCartToolDelegate> delegate;

@end
