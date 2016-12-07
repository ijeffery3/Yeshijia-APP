//
//  BasketGoodsModel.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/5.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "BasketGoodsModel.h"

@implementation BasketGoodsModel

+ (instancetype)initWithDic:(NSDictionary *)dict
{
    BasketGoodsModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
