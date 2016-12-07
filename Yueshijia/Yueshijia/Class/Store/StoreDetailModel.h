//
//  StoreDetailModel.h
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/29.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreDetailModel : NSObject

@property (nonatomic, strong) NSString *goods_image_url ;
@property (nonatomic, strong) NSString *goods_name ;
@property (nonatomic, strong) NSString *goods_jingle ;
@property (nonatomic, strong) NSString *goods_price ;
@property (nonatomic, strong) NSString *goods_marketprice ;

@property (nonatomic, strong) NSString *goods_salenum;

+ (instancetype)initWithDict:(NSDictionary *)dict;

@end
