//
//  ActivityModel.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_image;
@property (nonatomic, strong) NSString *hint_virtual;
@property (nonatomic, strong) NSString *end_virtual;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
