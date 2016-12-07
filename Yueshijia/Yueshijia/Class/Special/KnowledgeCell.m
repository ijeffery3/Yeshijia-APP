//
//  KnowledgeCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "KnowledgeCell.h"
#import "Knowledge.h"
#import "UIImageView+WebCache.h"

@interface KnowledgeCell()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *qaLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end

@implementation KnowledgeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width = ScreenWidth;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"KnowledgeCell";
    
    KnowledgeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(Knowledge *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    });
    
    self.titleLabel.text = model.article_title;
    self.descLabel.text = model.article_abstract;
    
}



- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.descLabel.frame) + 25;
}

@end
