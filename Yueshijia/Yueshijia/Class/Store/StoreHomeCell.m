//
//  StoreHomeCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/30.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "StoreHomeCell.h"
#import "StoreHomeModel.h"
#import "UIImageView+WebCache.h"

@interface StoreHomeCell ()

@property (nonatomic, weak) UIImageView *picImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *marketPriceLabel;
@property (nonatomic, weak) UILabel *saleNumLabel;

@end

@implementation StoreHomeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI
{
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.picImageView = picImageView;
    [self.contentView addSubview:picImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    priceLabel.textColor = ThemeColor;
    priceLabel.font = [UIFont systemFontOfSize:13];
    self.priceLabel = priceLabel;
    [self.contentView addSubview:priceLabel];
    
    UILabel *marketPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    marketPriceLabel.textColor = [UIColor lightGrayColor];
    marketPriceLabel.font = [UIFont systemFontOfSize:13];
    self.marketPriceLabel = marketPriceLabel;
    [self.contentView addSubview:marketPriceLabel];
    
    UILabel *saleNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    saleNumLabel.textColor = [UIColor lightGrayColor];
    saleNumLabel.textAlignment=NSTextAlignmentRight;
    saleNumLabel.font = [UIFont systemFontOfSize:13];
    self.saleNumLabel = saleNumLabel;
    [self.contentView addSubview:saleNumLabel];
}

- (void)setIsGrid:(BOOL)isGrid
{
    _isGrid = isGrid;
    
    if (isGrid) {
        
      
        [self.picImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(5);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(self.width - 60, self.width - 60));
        }];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.picImageView.mas_bottom).offset(5);
            make.left.mas_equalTo(self.contentView.mas_left);
            make.size.mas_equalTo(CGSizeMake( ScreenWidth/2 , 20));
        }];
        [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(self.contentView.mas_left);
            make.size.mas_equalTo(CGSizeMake(60 , 20));
        }];
        [self.marketPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceLabel.mas_bottom);
            make.left.mas_equalTo(self.priceLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(60 , 20));
        }];
        
        [self.saleNumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceLabel.mas_top);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.size.mas_equalTo(CGSizeMake(100 , 20));
        }];
        [super updateConstraints];
        
    } else {
        [self.picImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(5);
            make.left.mas_equalTo(self.contentView).offset(5);
            make.size.mas_equalTo(CGSizeMake(self.height - 10, self.height - 10));
        }];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.picImageView.mas_top);
            make.left.mas_equalTo(self.picImageView.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake( ScreenWidth/2 , 20));
        }];
        [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(100 , 20));
        }];
        [self.marketPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(8);
            make.left.mas_equalTo(self.priceLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(100 , 20));
        }];
        
        [self.saleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceLabel.mas_top);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-50);
            make.size.mas_equalTo(CGSizeMake(100 , 20));
        }];
        [super updateConstraints];
    }
}




- (void)setModel:(StoreHomeModel *)model
{
    _model = model;
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    self.titleLabel.text = model.goods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    NSString *origPricetext = [NSString stringWithFormat:@"￥%@",model.goods_marketprice];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc] initWithString:origPricetext
                                    attributes:
     @{
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    self.marketPriceLabel.attributedText = attrStr;
    self.saleNumLabel.text = [NSString stringWithFormat:@"已售%@件",model.goods_salenum];
}

@end
