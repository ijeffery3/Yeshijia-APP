//
//  BasketGoodsModel.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/5.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasketGoodsModel : NSObject
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_desc;
@property (nonatomic, strong) NSString *goods_price;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_num;

@property (nonatomic, assign) BOOL selectBtn;

+ (instancetype)initWithDic:(NSDictionary *)dict;
@end
