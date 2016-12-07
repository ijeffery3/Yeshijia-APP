//
//  Knowledge.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Knowledge : NSObject

@property (nonatomic, strong) NSString *article_title;
@property (nonatomic, strong) NSString *article_image;
@property (nonatomic, strong) NSString *article_abstract;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
