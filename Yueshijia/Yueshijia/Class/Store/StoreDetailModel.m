//
//  StoreDetailModel.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/29.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "StoreDetailModel.h"

@implementation StoreDetailModel

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    StoreDetailModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
