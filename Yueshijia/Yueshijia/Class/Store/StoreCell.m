//
//  StoreCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "StoreCell.h"
#import "StoreModel.h"
#import "UIImageView+WebCache.h"

@interface StoreCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end

@implementation StoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.width = ScreenWidth;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"StoreCell";
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}


- (void)setModels:(StoreModel *)models
{
    _models = models;
    
    self.titleLabel.text = models.special_title;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:models.special_image] placeholderImage:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}

- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.picImageView.frame) + 15;
    
}

@end
