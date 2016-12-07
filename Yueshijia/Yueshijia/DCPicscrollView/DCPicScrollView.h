//
//  basePicScrollView.h
//  DCWebPicScrollView
//
//  Created by dengchen on 15/12/5.
//  Copyright © 2015年 name. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PageControlStyle) {
    PageControlAtCenter,
    PageControlAtRight,
};

@interface DCPicScrollView : UIView

//占位图片
@property (nonatomic,strong) UIImage *placeImage;

@property (nonatomic,assign) NSTimeInterval AutoScrollDelay; //default is 2.0f,如果小于0.5不自动播放

//设置PageControl位置
@property (nonatomic,assign) PageControlStyle style; //default is PageControlAtCenter

@property (nonatomic,copy) NSArray<NSString *> *titleData; //设置后显示label,自动设置PageControlAtRight

//图片被点击会调用该block
@property (nonatomic,copy) void(^imageViewDidTapAtIndex)(NSInteger index); //index从0开始

/*@parameter imageUrl
 imageUrlString或imageName
 网络加载urlsring必须为http:// 开头,
//本地加载只需图片名字数组
*/
+ (instancetype)picScrollViewWithFrame:(CGRect)frame WithImageUrls:(NSArray<NSString *> *)imageUrl;



@property (nonatomic,strong) UIColor *pageIndicatorTintColor;

@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;

//default is [[UIColor alloc] initWithWhite:0.5 alpha:1]
@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,strong) UIFont *font;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com