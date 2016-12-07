//
//  shopCell.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "shopCell.h"

@interface shopCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation shopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = RGB(211, 192, 162).CGColor;
}

- (void)setPciName:(NSString *)pciName
{
    _pciName = pciName;
    self.imageView.image = [UIImage imageNamed:pciName];
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.nameLabel.text = name;
}

- (void)setPrice:(NSString *)price
{
    _price = price;
    self.priceLabel.text = price;
}

@end
