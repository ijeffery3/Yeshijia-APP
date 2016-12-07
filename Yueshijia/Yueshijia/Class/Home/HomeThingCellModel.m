//
//  HomeThingCellModel.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "HomeThingCellModel.h"

@implementation HomeThingCellModel

+ (instancetype)initWithDic:(NSDictionary *)dict
{
    HomeThingCellModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
