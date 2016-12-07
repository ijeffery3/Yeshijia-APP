//
//  HomeThingCellModel.h
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeThingCellModel : NSObject


@property (nonatomic, strong) NSString *relation_object_image;

@property (nonatomic, strong) NSString *relation_object_title;
@property (nonatomic, strong) NSString *relation_object_jingle;
@property (nonatomic, strong) NSString *goods_price;

+ (instancetype)initWithDic:(NSDictionary *)dict;

@end
