//
//  StoreDetailCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/29.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "StoreDetailCell.h"
#import "StoreDetailModel.h"
#import "UIImageView+WebCache.h"

@interface StoreDetailCell()
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopDesc;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *origPrice;
@property (weak, nonatomic) IBOutlet UILabel *saleNum;


@end

@implementation StoreDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"StoreDetailCell";
    StoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setModel:(StoreDetailModel *)model
{
    _model = model;
    self.shopName.text = model.goods_name;
    self.shopDesc.text = model.goods_jingle;
    self.price.text = [NSString stringWithFormat:@"￥ %@",model.goods_price];
    NSString *origPricetext = [NSString stringWithFormat:@"原价: %@",model.goods_marketprice];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc] initWithString:origPricetext
                                    attributes:
     @{
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];

    self.origPrice.attributedText =  attrStr;
    self.saleNum.text = [NSString stringWithFormat:@"已售: %@件",model.goods_salenum] ;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url]];
    });
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.width = ScreenWidth;
}

- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.saleNum.frame) + 15;
    
}

@end
