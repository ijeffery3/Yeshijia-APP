//
//  MapModel.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "MapModel.h"

@implementation MapModel
+ (instancetype)initWithDic:(NSDictionary *)dict
{
    MapModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
