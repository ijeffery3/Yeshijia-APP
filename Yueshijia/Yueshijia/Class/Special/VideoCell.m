//
//  VideoCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "VideoCell.h"
#import "UIImageView+WebCache.h"
#import "VideoModel.h"

@interface VideoCell()



@end

@implementation VideoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"VideoCell";
    
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(VideoModel *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    });
    self.timeLabel.text = model.video_length;
    self.titleLabel.text = model.article_title;
    self.descLabel.text = model.article_abstract;
    
}



- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.descLabel.frame) + 25;
}


- (IBAction)playBtnClick:(id)sender {
}

@end
