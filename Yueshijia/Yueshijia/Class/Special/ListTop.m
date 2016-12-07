//
//  ListTop.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/3.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "ListTop.h"

@implementation ListTop

+ (instancetype)initWithDic:(NSDictionary *)dict
{
    ListTop *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
