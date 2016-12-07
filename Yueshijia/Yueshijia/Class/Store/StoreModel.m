//
//  StoreModel.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel


+ (instancetype)initWithDic:(NSDictionary *)dict
{
    StoreModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
