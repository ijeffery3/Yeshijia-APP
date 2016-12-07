//
//  StoreModel.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, strong) NSString *special_title;
@property (nonatomic, strong) NSString *special_image;

+ (instancetype)initWithDic:(NSDictionary *)dict;
@end
