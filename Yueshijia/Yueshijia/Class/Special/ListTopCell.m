//
//  ListTopCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "ListTopCell.h"
#import "UIImageView+WebCache.h"
#import "ListTop.h"


@interface ListTopCell()
@property (weak, nonatomic) IBOutlet UIView *aView;

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;


@end

@implementation ListTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.width = ScreenWidth;
    self.aView.layer.borderColor = ThemeColor.CGColor;
    self.aView.layer.borderWidth = 0.5;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ListTopCell";
    
    ListTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(ListTop *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    });
    self.abstractLabel.text = model.article_abstract;
    self.topLabel.text = [NSString stringWithFormat:@"TOP %@",model.top];
    self.titleLabel.text = model.article_title;
    self.fromLabel.text = model.article_origin;
    
}



- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.fromLabel.frame) + 25;
}


@end
