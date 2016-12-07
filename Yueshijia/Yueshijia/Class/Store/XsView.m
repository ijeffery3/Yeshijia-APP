//
//  XsView.m
//  Yueshijia
//
//  Created by JefferyWan on 2016/11/27.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "XsView.h"
#import "UIImageView+WebCache.h"

@interface XsView()

@property (nonatomic, weak) UIImageView *picImageView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *nowPriceLabel;

@property (nonatomic, weak) UILabel *oldPriceLabel;

@property (nonatomic, weak)  UILabel *descLabel;


@end

@implementation XsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.height)];
        self.picImageView = picImageView;
        [self addSubview:picImageView];
        
        UIImageView *bImageView = [[UIImageView alloc] init];
        bImageView.image = [UIImage imageNamed:@"InfoCelltitle"];
        [picImageView addSubview:bImageView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        [bImageView addSubview:titleLabel];
        
        UILabel *nowPriceLabel = [[UILabel alloc] init];
        self.nowPriceLabel = nowPriceLabel;
        [bImageView addSubview:nowPriceLabel];
        
        UILabel *oldPriceLabel = [[UILabel alloc] init];
        self.oldPriceLabel = oldPriceLabel;
        [bImageView addSubview:oldPriceLabel];
        
        UILabel *descLabel = [[UILabel alloc] init];
        self.descLabel = descLabel;
        [bImageView addSubview:descLabel];
        
        UIView *aLine = [[UIView alloc] init];
        aLine.backgroundColor = ThemeColor;
        [bImageView addSubview:aLine];
        
        UIView *bLine = [[UIView alloc] init];
        bLine.backgroundColor = ThemeColor;
        [bImageView addSubview:bLine];
        
//        [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self);
//            make.left.mas_equalTo(self);
//            make.right.mas_equalTo(self);
//            make.bottom.mas_equalTo(self);
//        }];
        
        [bImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(picImageView.mas_top).offset(20);
            make.left.equalTo(picImageView.mas_left).offset(50);
            make.right.equalTo(picImageView.mas_right).offset(-50);
            make.bottom.equalTo(picImageView.mas_bottom).offset(-20);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(bImageView.mas_top).offset(28);
            make.left.equalTo(bImageView).offset(20);
            make.right.equalTo(bImageView).offset(-20);
            make.height.mas_equalTo(25);
        }];
        
        [aLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(8);
            make.left.equalTo(titleLabel).offset(20);
            make.right.equalTo(titleLabel).offset(-20);
            make.height.mas_equalTo(1);
        }];
        
        [nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(aLine.mas_bottom).offset(5);
            make.right.equalTo(aLine.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 25));
        }];
        
        [oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nowPriceLabel.mas_top);
            make.left.equalTo(nowPriceLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(100, 25));
        }];
        
        [bLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nowPriceLabel.mas_bottom).offset(8);
            make.left.equalTo(titleLabel).offset(20);
            make.right.equalTo(titleLabel).offset(-20);
            make.height.mas_equalTo(1);
        }];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bLine.mas_bottom).offset(8);
            make.left.mas_equalTo(bLine.mas_left);
            make.right.mas_equalTo(bLine.mas_right);
            make.height.mas_equalTo(21);
        }];
        
    }
    
    return self;
}

- (void)setBgImageName:(NSString *)bgImageName
{
    _bgImageName = bgImageName;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:bgImageName] placeholderImage:nil];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont systemFontOfSize:17.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setNowPrice:(NSString *)nowPrice
{
    _nowPrice= nowPrice;
    self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@",nowPrice];
    self.nowPriceLabel.font = [UIFont systemFontOfSize:16.0];
    self.nowPriceLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setOrigPrice:(NSString *)origPrice
{
    _origPrice = origPrice;
    self.oldPriceLabel.text = [NSString stringWithFormat:@"￥%@",origPrice];
    self.oldPriceLabel.font = [UIFont systemFontOfSize:13.0];
    self.oldPriceLabel.textAlignment = NSTextAlignmentCenter;
    self.oldPriceLabel.textColor = [UIColor lightGrayColor];
    
    NSAttributedString *attrStr =
    [[NSAttributedString alloc] initWithString:origPrice
                                    attributes:
     @{
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    
    self.oldPriceLabel.attributedText = attrStr;
}

- (void)setDesc:(NSString *)desc
{
    _desc = desc;
    self.descLabel.text = desc;
    self.descLabel.font = [UIFont systemFontOfSize:11.0];
    self.descLabel.textAlignment = NSTextAlignmentCenter;
}
@end
