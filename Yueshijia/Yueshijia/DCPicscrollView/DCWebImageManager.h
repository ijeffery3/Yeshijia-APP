//
//  DCWebImageManager.h
//  DCWebPicScrollView
//
//  Created by dengchen on 15/12/7.
//  Copyright © 2015年 name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCWebImageManager : NSObject



//只需要设置这2个就行了

//下载失败重复下载次数,默认不重复,
@property (nonatomic,assign) NSUInteger DownloadImageRepeatCount;

//图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
//error错误信息
//url下载失败的imageurl
@property (nonatomic,copy) void(^downLoadImageError)(NSError *error,NSString *imageUrl);





//内存缓存
@property (nonatomic,strong) NSMutableDictionary *webImageCache;

+ (instancetype)shareManager;

//下载到的图片都会被保存到webImageCache和沙盒中,key为urlString
- (void)downloadImageWithUrlString:(NSString *)urlSting;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com