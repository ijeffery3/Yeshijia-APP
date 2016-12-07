//
//  StoreHomeModel.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/30.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "StoreHomeModel.h"

@implementation StoreHomeModel

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    StoreHomeModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
