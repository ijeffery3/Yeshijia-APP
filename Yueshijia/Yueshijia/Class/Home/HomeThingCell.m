//
//  HomeThingCell.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "HomeThingCell.h"
#import "UIImageView+WebCache.h"
#import "HomeThingCellModel.h"

@interface HomeThingCell()


@property (weak, nonatomic) IBOutlet UIImageView *picImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIButton *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *likebtl;

@end

@implementation HomeThingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeCell";
    HomeThingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.width = ScreenWidth;
    self.priceLabel.layer.borderWidth = 0.5;
    self.priceLabel.layer.borderColor = RGB(211, 192, 162).CGColor;
    self.priceLabel.layer.cornerRadius = 5.0;
    self.likebtl.layer.borderWidth = 0.5;
    self.likebtl.layer.borderColor = RGB(211, 192, 162).CGColor;
    self.likebtl.layer.cornerRadius = 5.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(HomeThingCellModel *)model
{
    _model = model;
    
    [self.picImage sd_setImageWithURL:[NSURL URLWithString:model.relation_object_image]];
    self.nameLabel.text = model.relation_object_title;
    [self.priceLabel setTitle:[NSString stringWithFormat:@"$ %@",model.goods_price] forState:UIControlStateNormal];
    self.descLabel.text = model.relation_object_jingle;
}

- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.descLabel.frame) + 35;
    
}

@end
