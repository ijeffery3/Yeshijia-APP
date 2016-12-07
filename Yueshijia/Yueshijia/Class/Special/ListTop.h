//
//  ListTop.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/3.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListTop : NSObject

@property (nonatomic, strong) NSString *article_title;
@property (nonatomic, strong) NSString *article_image;
@property (nonatomic, strong) NSString *article_abstract;
@property (nonatomic, strong) NSString *article_origin;
@property (nonatomic, strong) NSString *top;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
