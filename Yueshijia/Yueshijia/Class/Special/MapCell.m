//
//  MapCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "MapCell.h"

#import "UIImageView+WebCache.h"
#import "MapModel.h"

@interface MapCell()
@property (weak, nonatomic) IBOutlet UILabel *localLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;



@end

@implementation MapCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.width = ScreenWidth;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MapCell";
    
    MapCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(MapModel *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    });
    self.localLabel.text = model.article_title;
    self.titleLabel.text = model.article_abstract;
    
}



- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.picImageView.frame) + 35;
}

@end
