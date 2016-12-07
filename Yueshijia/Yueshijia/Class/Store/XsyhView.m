//
//  XsyhView.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "XsyhView.h"
#import "UIImageView+WebCache.h"

@interface XsyhView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *origPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation XsyhView

+ (XsyhView *)initXshyView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"XsyhView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}

- (void)awakeFromNib
{
    
    [super awakeFromNib];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc] initWithString:self.origPriceLabel.text
                                    attributes:
     @{
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    
    self.origPriceLabel.attributedText = attrStr;
}

- (void)drawRect:(CGRect)rect
{
  
}

- (void)setBgImageName:(NSString *)bgImageName
{
    _bgImageName = bgImageName;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:bgImageName] placeholderImage:nil];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setNowPrice:(NSString *)nowPrice
{
    _nowPrice= nowPrice;
    self.nowPriceLabel.text = nowPrice;
}

- (void)setOrigPrice:(NSString *)origPrice
{
    _origPrice = origPrice;
    self.origPriceLabel.text = origPrice;
}

- (void)setDesc:(NSString *)desc
{
    _desc = desc;
    self.descLabel.text = desc;
}


@end
