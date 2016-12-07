//
//  ActivityCell.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/12/1.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+WebCache.h"
#import "ActivityModel.h"
#import "SDWebImageManager.h"
#import "UIImage+AIImage.h"

@interface ActivityCell()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;


@end

@implementation ActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.width = ScreenWidth;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MapCell";
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(ActivityModel *)model
{
    _model = model;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.goods_image] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            UIImage *newImage = [UIImage imageWithOriginImage:image scaleToSize:self.picImageView.frame.size];
//            self.picImageView.image = newImage;
//        }];
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    });
    
    self.nameLabel.text = model.goods_name;
    self.endLabel.text = model.end_virtual;
    self.hintLabel.text = model.hint_virtual;
}





- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.picImageView.frame) + 35;
}

@end
