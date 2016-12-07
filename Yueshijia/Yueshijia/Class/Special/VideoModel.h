//
//  VideoModel.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSString *article_title;
@property (nonatomic, strong) NSString *article_video;
@property (nonatomic, strong) NSString *article_image;
@property (nonatomic, strong) NSString *article_abstract;
@property (nonatomic, strong) NSString *video_length;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
