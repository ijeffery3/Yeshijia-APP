//
//  BasketGoodsCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/5.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "BasketGoodsCell.h"
#import "BasketGoodsModel.h"
#import "UIImageView+WebCache.h"

@interface BasketGoodsCell()
@property (weak, nonatomic) IBOutlet UIImageView *selectmageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;


@end

@implementation BasketGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allSelectClicked)];
    [self.selectmageView addGestureRecognizer:tap];
}

- (void)allSelectClicked
{
    NSLog(@"--------");
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"BasketGoodsCell";
    
    BasketGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(BasketGoodsModel *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    });

    self.selectBtn.selected = model.selectBtn;
    self.goodsNameLabel.text = model.goods_name;
    self.goodsDescLabel.text = model.goods_desc;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    self.goodsNumLabel.text = [NSString stringWithFormat:@"x%@",model.goods_num];
    
}

- (IBAction)selectBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(selectGoodsClick:btn:)]) {
        [self.delegate selectGoodsClick:self.indexPath btn:sender];
    }
}

@end
